class Event < ActiveRecord::Base

  has_many :registrations, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user
  has_many :characterizations, dependent: :destroy
  has_many :categories, through: :characterizations

  validates :name, presence: true, uniqueness: true
  validates :slug, uniqueness: true
  validates :location, presence: true
  validates :starts_at, presence: true
  validates :description, presence: true, length: { maximum: 500 }
  validates :price, numericality: { greater_than_or_equal_to: 0 } 
  validates :capacity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :image_file_name, allow_blank: true, format: { 
    with: /\w+\.(gif|jpg|png)\z/i, 
    message: "must reference a GIF, JPG, or PNG image" 
  }
  before_validation :generate_slug

  scope :upcoming, -> { where('starts_at >= ?', Time.now).order("starts_at ASC") }
  scope :past, -> { where('starts_at < ?', Time.now).order("starts_at DESC") }
  scope :free, -> { upcoming.where(price: 0.00) }
  scope :recently_added, ->(max=5) { where('starts_at >= ?', Time.now).order("created_at DESC").limit(max) }

  def free?
    price.blank? || price.zero?
  end

  def spots_left
    if capacity.zero?
      0
    else
      capacity - registrations.size
    end
  end

  def sold_out?
    spots_left.zero?
  end

  def to_param
    slug
  end

  def generate_slug
    self.slug ||= name.parameterize if name
  end
end
