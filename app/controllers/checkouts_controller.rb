class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  def show
    current_user.set_payment_processor :stripe
    current_user.payment_processor.payment_method_token = params[:payment_method_token]
    @checkout_session = current_user.payment_processor.checkout(
      mode: "payment",
      line_items: 'price_1Jrc1cCStSxJzrVqqCSRgtnR',
      metadata: { ad_id: params[:id] },
      success_url: success_checkouts_url,
      cancel_url: root_url
    )
  end

  def success
    @ad_id = Stripe::Checkout::Session.retrieve(params[:session_id]).metadata.ad_id
    @ad = set_ad(@ad_id)
    @ad.update(featured: true)
  end

  private
  def set_ad(ad_id)
    @ad = current_user.ads.find(ad_id)
  end
end
