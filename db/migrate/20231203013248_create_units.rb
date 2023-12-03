class CreateUnits < ActiveRecord::Migration[7.1]
  def change
    create_table :units do |t|
      t.integer :number
      t.string :floor_plan

      t.timestamps
    end
  end
end
