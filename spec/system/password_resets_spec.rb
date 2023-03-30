require 'rails_helper'

RSpec.describe "PasswordResets", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe "#new" do
    it "正しいパス" do
      visit new_password_reset_path
      expect(current_path).to eq "/password_resets/new"
    end
  end

end
