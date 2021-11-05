class PostAdStepsController < ApplicationController
  include Wicked::Wizard
  steps :add_images

  def show
    @ad = current_user.ads.find(params[:ad_id])
    render_wizard
  end

  def update
    @ad = current_user.ads.find(params[:ad_id])
    if ((params[:ad]).present?)
      @ad.images.attach(params[:ad][:images])
    end
    render_wizard
  end

  private

    def redirect_to_finish_wizard
      redirect_to root_url, notice: 'Your ad is posted.'
    end
end
