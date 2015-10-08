class CreatePrettyNumbers < ActiveRecord::Migration
  def change
    create_table :pretty_numbers do |t|
      t.string :name
      t.string :abbreviation_name
      t.integer :number_min_length
      t.integer :number_max_length	
      t.timestamps null: false
    end
  end
end
