class PaymentService
  class << self
    include Rails.application.routes.url_helpers

    def pay(user, payment_params)
      user.set_payment_processor('stripe')
      user.payment_processor.payment_method_token = payment_params[:payment_method_token]

      user.payment_processor.checkout(
        mode: 'payment',
        line_items: 'price_1Jrc1cCStSxJzrVqqCSRgtnR',
        metadata: { ad_id: payment_params[:id] },
        success_url: success_checkouts_url,
        cancel_url: root_url
      )
    end

    def validate_success(session_id, user)
      ad_id = Stripe::Checkout::Session.retrieve(session_id).metadata.ad_id
      ad = user.ads.find(ad_id)
      ad.update(featured: true)
    end
  end
end
