require 'rails_helper'

RSpec.describe UsersHelper, type: :helper do
    describe "永続的セッションのテスト" do
        let(:user) { FactoryBot.create(:user) }
        before do
            remember user
        end
    
        context "sessionがnilの時" do
            it "current_userはuserと同じである" do
                expect(current_user).to eq user
                expect(is_logged_in?).to be_truthy
            end
        end

        context "remember digestが間違っている時" do
            it "currnt_userはnilである" do
                user.update_attribute(:remember_digest, User.digest(User.new_token))
                expect(current_user).to eq nil
            end
        end
    end
end
