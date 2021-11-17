class Ad < ApplicationRecord
  include PgSearch::Model

  enum status: [ :active, :closed ]

  has_many_attached :images
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites
  has_rich_text :description
  belongs_to :user

  pg_search_scope :global_search, against: [:color, :city, :car_make, :engine_type, :transmission, :assembly_type, :mileage, :price, :engine_capacity]

  after_create do |ad|
    ad.update(status: "active")
  end

  CITIES = ['Rawalpindi', 'Lahore', 'Quetta', 'Karachi', 'Peshawar', 'Islamabad' ].freeze
  MAKE = ['Suzuki', 'Toyota', 'Honda', 'BMW' ].freeze
  ENGINE = ['Petrol', 'Diesel', 'Hybrid' ].freeze
  TRANSMISSION = ['Automatic', 'Manual' ].freeze
  ASSEMBLY = ['Local', 'Imported' ].freeze
  COLOR = ['Black', 'White', 'Other'].freeze
  PK_PHONE_REGEX = /^((\+92))-{0,1}\d{3}-{0,1}\d{7}$/

  validate :validate_images
  validates :city, inclusion: { in: CITIES, message: "%{value} is invalid" }
  validates :car_make, inclusion: { in: MAKE, message: "%{value} is invalid" }
  validates :transmission, inclusion: { in: TRANSMISSION, message: "%{value} is invalid" }
  validates :engine_type, inclusion: { in: ENGINE, message: "%{value} is invalid" }
  validates :color, presence: true
  validates :assembly_type, inclusion: { in:  ASSEMBLY, message: "%{value} is invalid" }
  validates :secondary_contact, format: {with: PK_PHONE_REGEX, message: "format should be +92-3XX-XXXXXXX", multiline: true}, allow_blank: true
  validates :mileage, numericality: true,  presence: true
  validates :price, numericality: true, presence: true
  validates :engine_capacity, numericality: true, presence: true

  private

  def validate_images
    return if images.count <= 5

    errors.add(:images, 'limit is upto 5')
  end
end
