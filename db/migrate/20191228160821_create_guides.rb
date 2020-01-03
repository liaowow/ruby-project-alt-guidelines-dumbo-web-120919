class CreateGuides < ActiveRecord::Migration[5.2]
  def change
    create_table :guides do |t|
      t.string :name
      t.string :password
      t.string :location
      t.string :specialty
      t.integer :years_of_experience

      t.timestamps
    end
  end
end
