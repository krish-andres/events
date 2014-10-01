class User < ActiveRecord::Base
  has_secure_password

  validates :name, presence: true
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: /\A\S+@\S+\z/

  def gravatar_id
    Digest::MD5::hexdigest(email.downcase)
  end
end
