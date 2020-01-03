class CreateTourists < ActiveRecord::Migration[5.2]
  def change
    create_table :tourists do |t|
      t.string :name
      t.string :password
      t.integer :num_of_people

      t.timestamps
    end
  end
end
