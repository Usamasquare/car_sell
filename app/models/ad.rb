class Ad < ApplicationRecord
  include PgSearch::Model

  enum status: [:active, :closed]

  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites

  has_rich_text :description

  has_many_attached :images

  pg_search_scope :global_search, against: [:color, :city, :car_make, :engine_type, :transmission, :assembly_type, :mileage, :engine_capacity]

  after_create do |ad|
    ad.update(status: 'active')
  end

  CITIES = %w[Rawalpindi Lahore Quetta Karachi Peshawar Islamabad].freeze
  MAKE = %w[Suzuki Toyota Honda BMW].freeze
  ENGINE = %w[Petrol Diesel Hybrid].freeze
  TRANSMISSION = %w[Automatic Manual].freeze
  ASSEMBLY = %w[Local Imported].freeze
  COLOR = %w[Black White Other].freeze

  PK_PHONE_REGEX = /^(\+92)-{0,1}\d{3}-{0,1}\d{7}$/.freeze

  validate :validate_images
  validates :city, inclusion: { in: CITIES, message: '%{value} is invalid' }
  validates :car_make, inclusion: { in: MAKE, message: '%{value} is invalid' }
  validates :transmission, inclusion: { in: TRANSMISSION, message: '%{value} is invalid' }
  validates :engine_type, inclusion: { in: ENGINE, message: '%{value} is invalid' }
  validates :color, presence: true
  validates :assembly_type, inclusion: { in: ASSEMBLY, message: '%{value} is invalid' }
  validates :secondary_contact, format: { with: PK_PHONE_REGEX, message: 'format should be +92-3XX-XXXXXXX', multiline: true }, allow_blank: true
  validates :mileage, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :engine_capacity, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def self.filter(params)
    filtered_result = Ad.all
    if params[:price_filter].present?
      if params[:price_filter].to_i == 51
        filtered_result = filtered_result.where('price > 50')
      else
        filtered_result = filtered_result.where(price: (0)..params[:price_filter].to_i)
      end
    end

    filtered_result = filtered_result.global_search(params[:city]) if params[:city].present?
    filtered_result = filtered_result.global_search(params[:color]) if params[:color].present?
    filtered_result = filtered_result.global_search(params[:mileage]) if params[:mileage].present?
    filtered_result = filtered_result.global_search(params[:car_make]) if params[:car_make].present?
    filtered_result = filtered_result.global_search(params[:engine_capacity]) if params[:engine_capacity].present?
    filtered_result = filtered_result.global_search(params[:engine_type]) if params[:engine_type].present?
    filtered_result = filtered_result.global_search(params[:assembly_type]) if params[:assembly_type].present?
    filtered_result = filtered_result.global_search(params[:transmission]) if params[:transmission].present?

    filtered_result
  end

  def toggle_status!
    if status == 'active'
      closed!
    else
      active!
    end
  end

  private

  def validate_images
    return if images.count <= 5

    errors.add(:images, 'limit is upto 5')
  end
end
