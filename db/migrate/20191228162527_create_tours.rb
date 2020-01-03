class CreateTours < ActiveRecord::Migration[5.2]
  def change
    create_table :tours do |t|
      t.string :name
      t.string :category
      t.string :location
      t.text :description
      t.integer :max_group_size
      t.string :availability
      t.float :duration
      t.string :date_time
      t.string :meetup_point
      t.float :price

      t.integer :guide_id
      t.integer :tourist_id

      t.timestamps
    end
  end
end
