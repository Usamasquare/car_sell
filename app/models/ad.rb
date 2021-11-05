class Ad < ApplicationRecord
  has_many_attached :images
  has_rich_text :description
  belongs_to :user

  CITIES = ['Rawalpindi', 'Lahore', 'Quetta', 'Karachi', 'Peshawar', 'Islamabad' ]
  MAKE = ['Suzuki', 'Toyota', 'Honda', 'BMW' ]
  ENGINE = ['Petrol', 'Diesel', 'Hybrid' ]
  TRANSMISSION = ['Automatic Manual', 'Manual' ]
  ASSEMBLY = ['Local', 'Imported']
  COLOR = ['Black' ,'White']

  validate :validate_images
  validates :city, inclusion: { in: CITIES, message: "%{value} is invalid" }
  validates :car_make, inclusion: { in: MAKE, message: "%{value} is invalid" }
  validates :transmission, inclusion: { in: TRANSMISSION, message: "%{value} is invalid" }
  validates :engine_type, inclusion: { in: ENGINE, message: "%{value} is invalid" }
  validates :color, presence: true
  validates :assembly_type, inclusion: { in:  ASSEMBLY, message: "%{value} is invalid" }
  #validates :secondary_contact, format: {with: PK_PHONE_REGEX, message: "format should be +92-3XX-XXXXXXX", multiline: true}
  validates :mileage, numericality: true,  presence: true
  validates :price, numericality: true, presence: true
  validates :engine_capacity, numericality: true, presence: true



  private

  def validate_images
    return if images.count <= 5

    errors.add(:images, 'limit is upto 5')
  end
end
