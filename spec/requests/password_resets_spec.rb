require "rails_helper"

RSpec.describe "PasswordResets", type: :request do
    let(:user) { FactoryBot.create(:user) }

    before do
        ActionMailer::Base.deliveries.clear
    end

    describe "#new" do
        it "パスが正しい" do
            get new_password_reset_path
            expect(response.body).to include "name=\"password_reset[email]\""
        end
    end

    describe "#create" do
        context "無効な値の場合" do
            it "フラッシュが出てnewにリダイレクト" do
                post password_resets_path, params: { password_reset: { email: "" } }
                expect(response).to have_http_status(422)
                expect(flash).to_not be_empty
                expect(response.body).to include "name=\"password_reset[email]\""
            end
        end

        context "正しい値の場合" do
            before do
                post password_resets_path, params: { password_reset: { email: user.email } }
            end

            it "reset_digestが更新される" do
                expect(user.reset_digest).to_not eq user.reload.reset_digest
            end

            it "メールが送られる" do
                mail_count = ActionMailer::Base.deliveries.size
                expect(mail_count).to eq 1
            end

            it "フラッシュが出てrootにリダイレクト" do
                expect(flash).to_not be_empty
                expect(response).to redirect_to root_path
            end
        end
    end

    describe "#edit" do
        before do
            post password_resets_path, params: { password_reset: { email: user.email } }
            @user = controller.instance_variable_get("@user")
        end

        context "失敗する" do
            it "未アクティブなユーザー" do
                @user.toggle!(:activated)
                get edit_password_reset_path(@user.reset_token, email: @user.email)
                expect(response).to redirect_to root_path
            end
            
            it "正しいトークンと正しくないメアド" do
                get edit_password_reset_path(@user.reset_token, email: "")
                expect(response).to redirect_to root_path
            end
    
            it "正しいメアドと正しくないトークン" do
                get edit_password_reset_path('wrong token', email: @user.email)
                expect(response).to redirect_to root_path
            end
        end

        context "成功する" do
            it "正しいメアドと正しいトークン" do
                get edit_password_reset_path(@user.reset_token, email: @user.email)
                expect(response).to have_http_status(200)
                expect(response.body).to include "<input type=\"hidden\" name=\"email\" id=\"email\" value=\"#{@user.email}\" autocomplete=\"off\" />"
            end
        end
    end

    describe "#update" do
        before do
            post password_resets_path, params: { password_reset: { email: user.email } }
            @user = controller.instance_variable_get('@user')
        end

        context "パスワードが有効な場合" do
            before do
                patch password_reset_path(@user.reset_token), params: { email: @user.email,
                                                                        user: { password:              "foobar",
                                                                                password_confirmation: "foobar" } }
            end

            it "ログインする" do
                expect(logged_in?).to be_truthy
            end

            it "フラッシュがでてユーザーページにリダイレクト" do
                expect(flash).to_not be_empty
                expect(response).to redirect_to @user
            end
        end

        context "パスワードが無効な値の場合" do
            it "パスワードと再入力が一致しなければエラーメッセージが出る" do
                patch password_reset_path(@user.reset_token), params: { email: @user.email,
                                                                        user: { password:              "foobar",
                                                                                password_confirmation: "hogehoge" } }
                expect(response.body).to include "<div id=\"error_explanation\">"
            end

            it "パスワードが空ならエラーメッセージが出る" do
                patch password_reset_path(@user.reset_token), params: { email: @user.email,
                                                                        user: { password:              "",
                                                                                password_confirmation: "" } }
                expect(response.body).to include "<div id=\"error_explanation\">"
            end
        end
    end
end