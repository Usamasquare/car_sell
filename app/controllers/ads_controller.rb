class AdsController < ApplicationController
  #include Search
  before_action :set_ad, only: %i[ activate close edit update destroy ]
  before_action :authenticate, only: [ :favorites ]
  skip_before_action :authenticate_user!, only: [ :index, :show ]

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

  def favorite
    @ad = Ad.find(params[:id])
    current_user.favorite_ads << @ad if current_user.favorite_ad_ids.exclude?(@ad.id)
    redirect_to ads_path
  end

  def unfavorite
    @ad = Ad.find(params[:id])
    if (current_user.favorite_ads.exists?(@ad.id))
      current_user.favorite_ads.delete(@ad.id)
    end

    redirect_to ads_path
  end

  def myfavorites
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
    respond_to do |format|
      if @ad.update(ad_params)
        format.html { redirect_to post_ad_steps_path(ad_id: @ad.id), notice: "Ad was successfully updated." }
        format.json { render :show, status: :ok, location: @ad }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ad.errors, status: :unprocessable_entity }
      end
    end
  end

  def close
    @ad.update(status: "closed")
    redirect_to ad_path(@ad)
  end

  def activate
    @ad.update(status: "active")
    redirect_to ad_path(@ad)
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

  def authenticate
      redirect_to new_user_registration_path unless user_signed_in?
  end

  def set_ad
    @ad = current_user.ads.find(params[:id])
  end

  def ad_params
    params.require(:ad).permit(:city, :mileage, :car_make, :price, :engine_type, :transmission, :engine_capacity, :color, :color_detail, :assembly_type, :description, images: [])
  end
end
