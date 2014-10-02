class User < ActiveRecord::Base
  has_secure_password
  has_many :registrations, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_events, through: :likes, source: :event

  validates :name, presence: true
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: /\A\S+@\S+\z/
  validates :slug, uniqueness: true
  before_validation :generate_slug

  def gravatar_id
    Digest::MD5::hexdigest(email.downcase)
  end

  def self.authenticate(email, password)
    user = User.find_by(email: email) 
    user && user.authenticate(password)
  end

  def to_param
    slug
  end

  def generate_slug
    self.slug ||= username.parameterize if username
  end
end
