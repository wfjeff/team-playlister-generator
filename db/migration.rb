Sequel.migration do
  change do
    create_table(:songs) do
      primary_key :id
      String :name
      String :artist_id
      String :genre_id 
    end

    create_table(:artists) do
      primary_key :id
      String :name
    end

    create_table(:songs) do
      primary_key :id
      String :name
    end
  end
end