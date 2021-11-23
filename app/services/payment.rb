class Payment

  def self.pay(user, payment_processor, payment_method_token, mode, price_Id, id, success, cancel)
    user.set_payment_processor(payment_processor)
    user.payment_processor.payment_method_token = payment_method_token

    user.payment_processor.checkout(
      mode: mode,
      line_items: price_Id,
      metadata: { ad_id: id },
      success_url: success,
      cancel_url: cancel
    )
  end

  def self.success(session_id, user)
    @ad_id = Stripe::Checkout::Session.retrieve(session_id).metadata.ad_id
    @ad = Payment.set_ad(@ad_id, user)
    @ad.update(featured: true)
    @ad_id
  end

  private
  def self.set_ad(ad_id, user)
    @ad = user.ads.find(ad_id)
  end

end
