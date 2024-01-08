class CreateRecommendations < ActiveRecord::Migration[6.1]
  def change
    create_table :recommendations do |t|
      t.integer :sake_id, null: false
      t.integer :snack_id, null: false

      t.timestamps
    end
  end
end
