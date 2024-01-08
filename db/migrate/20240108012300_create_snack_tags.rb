class CreateSnackTags < ActiveRecord::Migration[6.1]
  def change
    create_table :snack_tags do |t|
      t.integer :snack_id, null: false
      t.integer :tag_id, null: false

      t.timestamps
    end
  end
end
