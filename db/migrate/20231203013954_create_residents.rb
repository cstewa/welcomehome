class CreateResidents < ActiveRecord::Migration[7.1]
  def change
    create_table :residents do |t|
      t.string :name
      t.date :move_in_date
      t.date :move_out_date
      t.references :unit, null: false, foreign_key: true

      t.timestamps
    end
  end
end
