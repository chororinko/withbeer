class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.integer :snack_id, null: false
      t.string :ingredients, null: false
      t.text :process, null: false

      t.timestamps
    end
  end
end
