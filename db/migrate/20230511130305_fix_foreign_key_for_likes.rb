class FixForeignKeyForLikes < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :likes, :combos
    add_foreign_key :likes, :combos, on_delete: :cascade
  end
end
