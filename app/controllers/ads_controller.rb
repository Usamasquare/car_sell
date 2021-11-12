class AdsController < ApplicationController
  before_action :set_ad, only: %i[ edit update destroy ]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    @pagy, @ads = pagy(Ad.all, items: 3)
    @ads = @ads.all.global_search(params[:city])if(params[:city].present?)
    @ads = @ads.all.global_search(params[:color])if(params[:color].present?)
    @ads = @ads.all.global_search(params[:mileage])if(params[:mileage].present?)
    @ads = @ads.all.global_search(params[:car_make])if(params[:car_make].present?)
    @ads = @ads.all.global_search(params[:price])if(params[:price].present?)
    @ads = @ads.all.global_search(params[:engine_capacity])if(params[:engine_capacity].present?)
    @ads = @ads.all.global_search(params[:engine_type])if(params[:engine_type].present?)
    @ads = @ads.all.global_search(params[:assembly_type])if(params[:assembly_type].present?)
    @ads = @ads.all.global_search(params[:transmission])if(params[:transmission].present?)
    @colors = Array.new()
    Ad.select('color').distinct.each do |c|
      @colors << c.color
    end
  end

  def show
    @ad = Ad.find(params[:id])
  end

  def new
    @ad = Ad.new
  end

  def edit
  end

  def favorites
    if user_signed_in?
      f = Favorite.new()
      f.user_id = current_user.id
      f.ad_id = params[:id]
      f.save
      redirect_to ads_path
    else
      redirect_to new_user_registration_path
    end
  end

  def myfavorites
    @ads = Array.new()
    current_user.favorites.each do |fav|
      @ads << fav.ad
    end
    @pagy, @ads = pagy_array(@ads, items: 3)
  end

  def create
    @ad = Ad.new(ad_params)
    @ad.user = current_user
    current_user.ads << @ad
    if @ad.save
      redirect_to post_ad_steps_path(ad_id: @ad.id)
    else
      render :new
    end
  end

  def update
    respond_to do |format|
      if @ad.update(ad_params)
        format.html { redirect_to @ad, notice: "Ad was successfully updated." }
        format.json { render :show, status: :ok, location: @ad }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ad.errors, status: :unprocessable_entity }
      end
    end
  end

  def my_posts
    @pagy, @my_ads = pagy(current_user.ads.where(user_id: current_user.id), items: 3)
  end

  def destroy
    @ad.destroy
    respond_to do |format|
      format.html { redirect_to ads_url, notice: "Ad was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def record_not_found
    render plain: "404 Not Found", status: 404
  end

  def set_ad
    @ad = current_user.ads.find(params[:id])
  end

  def ad_params
    params.require(:ad).permit(:city, :mileage, :car_make, :price, :engine_type, :transmission, :engine_capacity, :color, :assembly_type, :description, images: [])
  end
end
