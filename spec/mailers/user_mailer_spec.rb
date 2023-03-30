require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  let!(:user) { FactoryBot.create(:user) }
  describe "account_activation" do
    let(:mail) { UserMailer.account_activation(user) }

    it "正しいタイトル" do
      expect(mail.subject).to eq ("仮登録完了のお知らせ")
    end

    it "正しい送信元" do
      expect(mail.from).to eq (["user@noreply.com"])
    end

    it "正しい送信先" do
      expect(mail.to).to eq ([user.email])
    end

    it "renders the body" do
      # expect(mail.body.encoded).to match("Hi")
    end
  end

  describe "password_reset" do
    let(:mail) { UserMailer.password_reset(user) }
    before do
      user.reset_token = User.new_token
    end

    it "正しいタイトル" do
      expect(mail.subject).to eq ("パスワードの再設定")
    end
    
    it "正しい送信元" do
      expect(mail.from).to eq (["user@noreply.com"])
    end
    
    it "正しい送信先" do
      expect(mail.to).to eq ([user.email])
    end

    it "正しい文面" do
      expect(mail.body.encoded).to match(CGI.escape(user.email))
    end
  end

end
