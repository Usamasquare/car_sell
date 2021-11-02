class Ad < ApplicationRecord
  has_many_attached :images

  validate :validate_images

  CITIES = ['Rawalpindi', 'Lahore', 'Quetta', 'Karachi', 'Peshawar', 'Islamabad' ]
  MAKE = ['Suzuki', 'Toyota', 'Honda', 'BMW' ]
  ENGINE = ['Petrol', 'Diesel', 'Hybrid' ]
  TRANSMISSION = ['Automatic Manual', 'Manual' ]
  ASSEMBLY = ['Local', 'Imported']
  COLOR = ['Black' ,'White']

  private

  def validate_images
    return if images.count <= 5

    errors.add(:images, 'limit is upto 5')
  end
end
