module DBable
  module ClassMethods
    def [](attr_hash)
      sql = <<-SQL
        SELECT * FROM #{table_name} WHERE #{attr_hash.collect{|k,v| "#{k} = '#{v}'" }.join(', ')};
      SQL
      result = DB[:conn].execute(sql)
      result = result.collect {|row| new_from_db(row)} if !result.empty?
      result
    end

    def all
      sql = <<-SQL
        SELECT * FROM #{table_name}
      SQL
      result = DB[:conn].execute(sql)
      result = result.collect {|row| new_from_db(row)} if !result.empty?
      result
    end

    def find_by_id(id)
      self[:id => id][0]
    end

    def create_table
      sql = <<-SQL
        CREATE TABLE IF NOT EXISTS #{table_name} (
            #{schema_definition}
            )
        SQL
      
      DB[:conn].execute(sql)
    end

    def table_name
      name.downcase + 's'
    end

    def schema_definition
      attributes.collect{|k,v| "#{k} #{v}"}.join(",")
    end

    def sql_for_update
      attributes.keys[1..-1].collect{|k| "#{k} = ?"}.join(",")
    end

    def drop_table
      sql = "DROP TABLE IF EXISTS #{table_name}"
      DB[:conn].execute(sql)
    end    

    def new_from_db(row)
      self.new.tap do |s|
        row.each_with_index do |value, index|
          s.send("#{attributes.keys[index]}=", value)
        end
      end
    end

    def find_by_name(name)
      sql = "SELECT * FROM #{table_name} WHERE name = ?"
        result = DB[:conn].execute(sql, name)[0] #[]    
        self.new_from_db(result) if result
    end

  end
  module InstanceMethods
    def update
        sql = "UPDATE #{table_name} SET #{sql_for_update} WHERE id = ?"
        DB[:conn].execute(sql, *attribute_values, id)
    end    

    def table_name
      self.class.table_name
    end


    def sql_for_update
      attributes.keys[1..-1].collect{|k| "#{k} = ?"}.join(",")
    end


    def attributes
      self.class.attributes
    end

    def persisted?
       !!self.id
    end

    def save
       persisted? ? update : insert
    end

    def attribute_values
      self.attributes.keys[1..-1].collect{|key| self.send(key)}
    end

    def question_marks_for_sql
      (attributes.keys.length - 1).times.collect{"?"}.join(',')
    end

    def insert
      sql = "INSERT INTO #{table_name} (#{self.attributes.keys[1..-1].join(",")}) VALUES (#{question_marks_for_sql})"
      DB[:conn].execute(sql, *attribute_values)

      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM #{table_name}")[0][0]
    end

    def initialize(arg_hash = {})
      arg_hash.each{|k,v| self.send("#{k}=", v)}
    end

    def url
     "#{name.downcase.gsub(/\W/, "-")}.html"
    end
  end
end