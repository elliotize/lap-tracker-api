Sequel.migration do
  up do
    add_column :events, :state, String
  end

  down do
    drop_column :events, :state
  end
end
