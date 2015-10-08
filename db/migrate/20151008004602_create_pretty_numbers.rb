class CreatePrettyNumbers < ActiveRecord::Migration
  def change
    create_table :pretty_numbers do |t|

      t.timestamps null: false
    end
  end
end
