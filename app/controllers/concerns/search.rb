module Search
  def filter(klass)
    @ads = klass.all
    @ads = @ads.global_search(params[:city]) if (params[:city].present?)
    @ads = @ads.global_search(params[:color]) if (params[:color].present?)
    @ads = @ads.global_search(params[:mileage]) if (params[:mileage].present?)
    @ads = @ads.global_search(params[:car_make]) if (params[:car_make].present?)
    @ads = @ads.global_search(params[:price]) if (params[:price].present?)
    @ads = @ads.global_search(params[:engine_capacity]) if (params[:engine_capacity].present?)
    @ads = @ads.global_search(params[:engine_type]) if (params[:engine_type].present?)
    @ads = @ads.global_search(params[:assembly_type]) if (params[:assembly_type].present?)
    @ads = @ads.global_search(params[:transmission]) if (params[:transmission].present?)

    return @ads
  end
end
