class AddLoginAttemptsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :login_attempts, :integer, default: 0
    add_column :users, :last_attempt_at, :datetime
  end
end
