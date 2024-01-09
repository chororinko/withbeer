class CreateSnacks < ActiveRecord::Migration[6.1]
  def change
    create_table :snacks do |t|
      t.integer :sake_id, null: false
      t.string :title, null: false
      t.text :introduction, null: false
      t.text :ingredients, null: false
      t.text :process, null: false

      t.timestamps
    end
  end
end
