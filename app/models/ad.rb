class Ad < ApplicationRecord
  include PgSearch::Model

  enum status: [ :active, :closed ]

  has_many_attached :images
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites
  has_rich_text :description
  belongs_to :user

  pg_search_scope :global_search, against: [:color, :city, :car_make, :engine_type, :transmission, :assembly_type, :mileage,  :engine_capacity]

  after_create do |ad|
    ad.update(status: 'active')
  end

  CITIES = ['Rawalpindi', 'Lahore', 'Quetta', 'Karachi', 'Peshawar', 'Islamabad' ].freeze
  MAKE = ['Suzuki', 'Toyota', 'Honda', 'BMW' ].freeze
  ENGINE = ['Petrol', 'Diesel', 'Hybrid' ].freeze
  TRANSMISSION = ['Automatic', 'Manual' ].freeze
  ASSEMBLY = ['Local', 'Imported' ].freeze
  COLOR = ['Black', 'White', 'Other'].freeze
  PK_PHONE_REGEX = /^((\+92))-{0,1}\d{3}-{0,1}\d{7}$/

  validate :validate_images
  validates :city, inclusion: { in: CITIES, message: '%{value} is invalid' }
  validates :car_make, inclusion: { in: MAKE, message: '%{value} is invalid' }
  validates :transmission, inclusion: { in: TRANSMISSION, message: '%{value} is invalid' }
  validates :engine_type, inclusion: { in: ENGINE, message: '%{value} is invalid' }
  validates :color, presence: true
  validates :assembly_type, inclusion: { in:  ASSEMBLY, message: '%{value} is invalid' }
  validates :secondary_contact, format: {with: PK_PHONE_REGEX, message: 'format should be +92-3XX-XXXXXXX', multiline: true}, allow_blank: true
  validates :mileage, numericality: true,  presence: true
  validates :price, numericality: true, presence: true
  validates :engine_capacity, numericality: true, presence: true

  def self.filter(params)
    @ads = Ad.all
    if(params[:desired_attribute].present?)
      if(params[:desired_attribute].to_i == 51)
        @ads = @ads.where('price > 50')
      else
        @ads = @ads.where(price: (0)..params[:desired_attribute].to_i)
      end
    end
    @ads = @ads.global_search(params[:city]) if (params[:city].present?)
    @ads = @ads.global_search(params[:color]) if (params[:color].present?)
    @ads = @ads.global_search(params[:mileage]) if (params[:mileage].present?)
    @ads = @ads.global_search(params[:car_make]) if (params[:car_make].present?)
    @ads = @ads.global_search(params[:engine_capacity]) if (params[:engine_capacity].present?)
    @ads = @ads.global_search(params[:engine_type]) if (params[:engine_type].present?)
    @ads = @ads.global_search(params[:assembly_type]) if (params[:assembly_type].present?)
    @ads = @ads.global_search(params[:transmission]) if (params[:transmission].present?)

    return @ads
  end

  private

  def validate_images
    return if images.count <= 5

    errors.add(:images, 'limit is upto 5')
  end
end
