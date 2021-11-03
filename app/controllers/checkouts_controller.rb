class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  def show
    current_user.set_payment_processor :stripe
    current_user.payment_processor
    current_user.payment_processor.customer
    current_user.payment_processor.payment_method_token = params[:payment_method_token]

    @checkout_session = current_user.payment_processor.checkout(
        mode: 'payment',
        line_items: 'price_1Jrc1cCStSxJzrVqqCSRgtnR'
      )
  end

end
