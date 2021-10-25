json.extract! ad, :id, :city, :mileage, :car_make, :price, :engine_type, :transmission, :engine_capacity, :color, :assembly_type, :description, :created_at, :updated_at
json.url ad_url(ad, format: :json)
