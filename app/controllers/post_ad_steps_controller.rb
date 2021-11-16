class PostAdStepsController < ApplicationController
  include Wicked::Wizard
  steps :add_images, :finalize

  def show
    case step
      when :add_images
        @ad = current_user.ads.find(params[:ad_id])
      when :finalize
        @ad = current_user.ads.find(params[:ad])
      end
    render_wizard
  end

  def update
    @ad = current_user.ads.find(params[:ad_id])
    case step
      when :add_images
        if params[:ad].present?
          @ad.images.attach(ad_params[:images])
        end
      when :finalize
        @ad.update(secondary_contact: ad_params[:secondary_contact])
      end
    render_wizard(@ad, {}, ad: @ad)
  end

  def destroy
    @ad = current_user.ads.find(params[:ad])
    @ad.images.find(params[:img]).purge
    redirect_to post_ad_steps_path(ad_id: @ad.id)

  end

  private

  def ad_params
    params.require(:ad).permit(:secondary_contact, images: []) if params[:ad].present?
  end

end
