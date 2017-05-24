Sequel.migration do
  up do
    create_table(:people) do
      primary_key :id

      String :first_name
      String :last_name
      String :email, unique: true
    end
  end

  down do
    drop_table(:people)
  end
end