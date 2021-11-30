class AdsController < ApplicationController
  before_action :set_ad, only: %i[activate close edit update destroy]
  before_action :set_global_ad, only: %i[show toggle_favorite]

  skip_before_action :authenticate_user!, only: [:index, :show]

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    @ads = Ad.filter(params)
    @pagy, @ads = pagy(@ads, items: 7)
    @colors = Ad.pluck(:color).reject(&:blank?).uniq
    @colors << Ad.pluck(:color_detail).reject(&:blank?).uniq
  end

  def show
    @ad = Ad.find(params[:id])
  end

  def new
    @ad = Ad.new
  end

  def edit
  end

  def toggle_favorite
    current_user.toggle_favorite_ad(@ad)
    redirect_to ads_path, notice: "Ad is removed from favorites"
  end

  def my_favorites
    @ads = current_user.favorite_ads
    @pagy, @ads = pagy(@ads, items: 6)
  end

  def create
    @ad = current_user.ads.new(ad_params)
    if @ad.save
      redirect_to post_ad_steps_path(ad_id: @ad.id)
    else
      render :new
    end
  end

  def update
    if @ad.update(ad_params)
      redirect_to post_ad_steps_path(ad_id: @ad.id), notice: "Ad was successfully updated."
    else
      render :edit
    end
  end

  def toggle_status
    @ad.toggle_status!
    redirect_to ad_path(@ad), notice: "Ad is closed successfully"
  end

  def my_posts
    @pagy, @my_ads = pagy(current_user.ads, items: 3)
  end

  def destroy
    @ad.destroy
    respond_to do |format|
      format.html { redirect_to my_posts_ads_url, notice: "Ad was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def record_not_found
    render plain: "404 Not Found", status: 404
  end

  def set_ad
    @ad = current_user.ads.find_by(id: params[:id])
    return if @ad.present?

    redirect_to root_path, alert: 'Invalid Access'
  end

  def set_global_ad
    @ad = Ad.find_by(id: params[:id])
    return if @ad.present?

    redirect_to root_path, alert: 'Invalid access'
  end

  def ad_params
    params.require(:ad).permit(:city, :mileage, :car_make, :price, :engine_type, :transmission, :engine_capacity, :color, :color_detail, :assembly_type, :description, images: [])
  end
end
