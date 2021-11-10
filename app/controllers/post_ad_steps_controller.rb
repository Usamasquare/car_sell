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
        if ((params[:ad]).present?)
          @ad.images.attach(params[:ad][:images])
        end
      when :finalize
        @ad.update(secondary_contact: params[:ad][:secondary_contact])
      end
    render_wizard(@ad,{},ad: @ad)
  end

end
