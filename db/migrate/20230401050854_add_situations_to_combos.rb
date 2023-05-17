class AddSituationsToCombos < ActiveRecord::Migration[7.0]
  def change
    add_column :combos, :situation, :string
  end
end
