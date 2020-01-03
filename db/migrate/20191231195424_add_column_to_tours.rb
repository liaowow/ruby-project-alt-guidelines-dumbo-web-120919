class AddColumnToTours < ActiveRecord::Migration[5.2]
  def change
    add_column :tours, :remaining_spots, :integer
  end
end
