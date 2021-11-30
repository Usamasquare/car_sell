class PostAdStepsController < ApplicationController
  include Wicked::Wizard

  before_action :set_ad, only: [:update, :show]

  steps :add_images, :finalize

  def show
    render_wizard
  end

  def update
    @ad.update(ad_params)
    render_wizard(@ad, {}, ad_id: @ad.id)
  end

  def destroy
    @ad = current_user.ads.find(params[:ad])
    @ad.images.find(params[:img]).purge
    redirect_to post_ad_steps_path(ad_id: @ad.id)
  end

  private

  def set_ad
    @ad = current_user.ads.find_by(id: params[:ad_id])
    return if @ad.present?

    redirect_to root_path, alert: 'Invalid Access'
  end

  def ad_params
    params.require(:ad).permit(:secondary_contact, images: [])
  end
end
