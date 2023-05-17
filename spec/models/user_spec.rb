require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:user) }
  describe "user validation" do
    
    it "user valid" do
      expect(user).to be_valid
    end

    it "name should be present" do
      user.name = "   "
      expect(user).to_not be_valid
    end

    it "email should be present" do
      user.email = "   "
      expect(user).to_not be_valid
    end

    it "名前の文字制限(~50)" do
      user.name = "a" * 51
      expect(user).to_not be_valid
    end

    it "メアドの文字制限(~255)" do
      user.email = "a" * 244 + "@hogehoge.com"
      expect(user).to_not be_valid
    end

    it "メアドの適切なフォーマット" do
      valid_addresses = %w[ user@hogehoge.com
                            USER@foo.COM
                            A_US-ER@foo.bar.org
                            first.last@foo.jp
                            alice+bob@baz.cn ]
      valid_addresses.each do |valid_address|
        user.email = valid_address
        expect(user).to be_valid
      end
    end

    it "メアドの不適切なフォーマット" do
      valid_addresses = %w[ userexample.com
                            USER@foo,COM
                            A_US-ER@foobarorg ]
      valid_addresses.each do |valid_address|
        user.email = valid_address
        expect(user).to_not be_valid
      end
    end

    it "メアドの一意性" do
      duplicate_user = user.dup
      user.save!
      expect(duplicate_user).to_not be_valid
    end

    it "パスワードは空白ではいけない" do
      user.password = user.password_confirmation = " " * 6
      expect(user).to_not be_valid
    end

    it "パスワードは6文字以上でなければならない" do
      user.password = user.password_confirmation = "a" * 5
      expect(user).to_not be_valid
    end
  end

  describe "user digest" do
    it "remember_digestが存在しない場合のauthenticated?" do
      expect(user.authenticated?(:remember ,"")).to_not be_truthy
    end
  end
end
