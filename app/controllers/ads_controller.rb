class AdsController < ApplicationController
  before_action :set_ad, only: %i[ show edit update destroy ]

  # GET /ads or /ads.json
  def index
    @ads = Ad.all
  end

  # GET /ads/1 or /ads/1.json
  def show
  end

  # GET /ads/new
  def new
    @ad = Ad.new
  end

  # GET /ads/1/edit
  def edit
  end

  # POST /ads or /ads.json
  def create
    @ad = Ad.new(ad_params)

    if @ad.save
      redirect_to post_ad_steps_path(ad_id: @ad.id)
    else
      render :new
    end
  end

  # PATCH/PUT /ads/1 or /ads/1.json
  def update
    redirect_to controller: 'post_ad_steps', action: 'update', ad_id: @ad.id
  end

  def finalize
  end

  # DELETE /ads/1 or /ads/1.json
  def destroy
    @ad.destroy
    respond_to do |format|
      format.html { redirect_to ads_url, notice: "Ad was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ad
      @ad = Ad.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ad_params
      params.require(:ad).permit(:city, :mileage, :car_make, :price, :engine_type, :transmission, :engine_capacity, :color, :assembly_type, :description, images: [])
    end
end
