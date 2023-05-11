class User < ApplicationRecord
    has_many :combo, dependent: :destroy
    has_many :likes, dependent: :destroy
    has_many :liked_combos, through: :likes, source: :combo
    attr_accessor :remember_token, :activation_token, :reset_token
    before_save   :downcase_email
    before_create :create_activation_digest
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates     :name,  presence: true, length: { maximum: 50}
    validates     :password, presence: true, length: { minimum: 6 }
    validates     :email,   presence: true, length: { maximum: 255},
                            format: { with: VALID_EMAIL_REGEX },
                            uniqueness: true
    has_secure_password

    def User.digest(string) # 渡された文字列のハッシュ値を返す
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
    

    def User.new_token # ランダムなトークンを返す
        SecureRandom.urlsafe_base64
    end

    def remember # remember_tokenをユーザーのデータベースに記憶する
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
        remember_digest
    end

    def session_token
        remember_digest || remember
    end

    def authenticated?(attribute, token) # 渡されたトークンがダイジェストと一致したらtrueを返す
        digest = send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end

    def forget # ユーザーのログイン情報を破棄する
        update_attribute(:remember_digest, nil)
    end

    def activate # アカウントを有効にする
        update_attribute(:activated,    true)
        update_attribute(:activated_at, Time.zone.now)
    end

    def send_activation_email # 有効化用のメールを送信する
        UserMailer.account_activation(self, self.activation_token).deliver_now
    end

    def create_reset_digest # パスワード再設定用のトークンを発行し保存する
        self.reset_token = User.new_token
        update_attribute(:reset_digest,  User.digest(reset_token))
        update_attribute(:reset_sent_at, Time.zone.now)
    end

    def send_password_reset_email # パスワード再設定のメールを送信する
        UserMailer.password_reset(self).deliver_now
    end

    def password_reset_expired? # パスワードの期限が切れていたらtrueを返す
        reset_sent_at < 2.hours.ago
    end

    def feed
        Combo.where("user_id= ?", id)
    end

    def feed_all
        Combo.all
    end

    def liked?(combo)
        likes.exists?(combo_id: combo.id)
    end

    def find_like(combo)
        likes.find_by(combo_id: combo.id)
    end

    def liked_combos
        Combo.joins(:likes).where(likes: {user_id: self.id})
    end

    private

        def downcase_email
            self.email = email.downcase
        end

        def create_activation_digest
            self.activation_token  = User.new_token
            self.activation_digest = User.digest(activation_token)
        end
end
