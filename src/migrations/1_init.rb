Sequel.migration do
  up do
    create_table(:people) do
      primary_key :id
      String :first_name, null: false
      String :last_name, null: false
      String :email, unique: true
      String :face_id, unique: true, null: true
    end

    create_table(:walks) do
      primary_key :id
      foreign_key :person_id, :people, null: false
      DateTime :start, null: false
      DateTime :end, null: false
    end

    create_table(:laps) do
      primary_key :id
      foreign_key :walk_id, :walks, null: false
      DateTime :start, null: false
      DateTime :end, null: false
    end

    create_table(:events) do
      primary_key :id
      foreign_key :face_id, :people, key: :face_id
      DateTime :timestamp, null: false
      String :location, null: false
    end
  end

  down do
    drop_table(:events)
    drop_table(:laps)
    drop_table(:walks)
    drop_table(:people)
  end
end
