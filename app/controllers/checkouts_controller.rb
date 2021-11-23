class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  def show
    @checkout_session = Payment.pay(current_user, 'stripe', params[:payment_method_token], 'payment', 'price_1Jrc1cCStSxJzrVqqCSRgtnR', params[:id], success_checkouts_url, root_url)
  end

  def success
    @ad_id = Payment.success(params[:session_id], current_user)
  end

end
