class User < ApplicationRecord
  # パスワードを暗号化するメソッド
  has_secure_password
  
  validates :email, presence: true, uniqueness: true

  # メールアドレスが正しい形式か正規表現で判定
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  # 新規レコードまたは、レコード更新かつパスワードが設定されている場合に、パスワードの最小の長さを設定する。
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
end
