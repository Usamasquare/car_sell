class Ad < ApplicationRecord
  has_one_attached :image

  CITIES = ['Rawalpindi', 'Lahore', 'Quetta', 'Karachi', 'Peshawar', 'Islamabad' ]
  MAKE = ['Suzuki', 'Toyota', 'Honda', 'BMW' ]
  ENGINE = ['Petrol', 'Diesel', 'Hybrid' ]
  TRANSMISSION = ['Automatic Manual', 'Manual' ]
  ASSEMBLY = ['Local', 'Imported']
  COLOR = ['Black' ,'White']


end
