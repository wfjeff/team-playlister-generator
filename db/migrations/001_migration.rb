Sequel.migration do
  change do
    create_table(:songs) do
      primary_key :id
      String :name
      Integer :artist_id
      Integer :genre_id 
    end

    create_table(:artists) do
      primary_key :id
      String :name
    end

    create_table(:genres) do
      primary_key :id
      String :name
    end
  end
end