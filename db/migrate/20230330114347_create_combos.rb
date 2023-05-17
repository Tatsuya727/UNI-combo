class CreateCombos < ActiveRecord::Migration[7.0]
  def change
    create_table :combos do |t|
      t.string :title
      t.text :description
      t.string :video_url
      t.integer :character_id
      t.integer :hit_count
      t.integer :damage
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :combos, [:user_id, :created_at, :character_id]
  end
end
