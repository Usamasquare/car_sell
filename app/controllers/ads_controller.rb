class AdsController < ApplicationController
  before_action :set_ad, only: %i[ show edit update destroy ]

  def index
    @pagy, @ads = pagy(Ad.all, items: 3)
    @ads = @ads.all.global_search(params[:city])if(params[:city].present?)
    @ads = @ads.all.global_search(params[:color])if(params[:color].present?)
    @ads = @ads.all.global_search(params[:mileage])if(params[:mileage].present?)
    @ads = @ads.all.global_search(params[:car_make])if(params[:car_make].present?)
    @ads = @ads.all.global_search(params[:price])if(params[:price].present?)
    @ads = @ads.all.global_search(params[:engine_capacity])if(params[:engine_capacity].present?)
    @ads = @ads.all.global_search(paras[:engine_type])if(params[:engine_type].present?)
    @ads = @ads.all.global_search(params[:assembly_type])if(params[:assembly_type].present?)
    @ads = @ads.all.global_search(params[:transmission])if(params[:transmission].present?)

  end

  def show
  end

  def new
    @ad = Ad.new
  end

  def edit
  end

  def create
    @ad = Ad.new(ad_params)
    @ad.user = current_user
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
    @my_ads = current_user.ads.where(user_id: current_user.id)
  end

  def destroy
    @ad.destroy
    respond_to do |format|
      format.html { redirect_to ads_url, notice: "Ad was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  def set_ad
    @ad = current_user.ads.find(params[:id])
  end

  def ad_params
    params.require(:ad).permit(:city, :mileage, :car_make, :price, :engine_type, :transmission, :engine_capacity, :color, :assembly_type, :description, images: [])
  end
end
