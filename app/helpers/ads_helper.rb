module AdsHelper
  def toggle_favorite_ad_text(ad)
    if current_user.favorite_ads.find_by(id: ad.id)
      return 'unfavorite'
    else
      return 'favorite'
    end
  end

  def toggle_status_ad_text(ad)
    if ad.status == 'active'
      return 'close'
    else
      return 'active'
    end
  end
end
