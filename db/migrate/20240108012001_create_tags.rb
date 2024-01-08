class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.string :cooking_genre, null: false
      t.integer :flavor, null: false
      t.integer :cooking_time, null: false


      t.timestamps
    end
  end
end
