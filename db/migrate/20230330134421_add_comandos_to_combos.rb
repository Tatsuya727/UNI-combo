class AddComandosToCombos < ActiveRecord::Migration[7.0]
  def change
    add_column :combos, :comando, :text
  end
end
