class CheckoutsController < ApplicationController

  def show
    @checkout_session = PaymentService.pay(current_user, params)
  end

  def success
    @ad_id = PaymentService.validate_success(params[:session_id], current_user)
  end

end
