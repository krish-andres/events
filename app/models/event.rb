class Event < ActiveRecord::Base

  has_many :registrations, dependent: :destroy

  validates :name, presence: true
  validates :location, presence: true
  validates :starts_at, presence: true
  validates :description, presence: true, length: { maximum: 500 }
  validates :price, numericality: { greater_than_or_equal_to: 0 } 
  validates :capacity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :image_file_name, allow_blank: true, format: { 
    with: /\w+\.(gif|jpg|png)\z/i, 
    message: "must reference a GIF, JPG, or PNG image" 
  }


  def free?
    price.blank? || price.zero?
  end

  def self.upcoming
    where('starts_at >= ?', Time.now).order("starts_at ASC")
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
end
