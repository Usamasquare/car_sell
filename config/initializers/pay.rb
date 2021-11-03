Pay.setup do |config|
  # For use in the receipt/refund/renewal mailers
  config.business_name = "CAR-SELL"
  config.business_address = "1600 Pennsylvania Avenue NW"
  config.application_name = "CAR-SELL"
  config.support_email = "usama.riaz@square63.org"

  config.send_emails = true

  config.default_product_name = "default"
  config.default_plan_name = "default"

  config.automount_routes = true
  config.routes_path = "/pay" # Only when automount_routes is true
end
