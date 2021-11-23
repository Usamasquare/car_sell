# module Search
#   def filter(klass)
#     @ads = klass.all
#     if(params[:desired_attribute].present?)
#       if(params[:desired_attribute] == 'Upto 5 lacs')
#         @ads = @ads.where(price: (0)..5)
#       elsif(params[:desired_attribute] == 'Upto 10 lacs')
#         @ads = @ads.where(price: (0)..10)
#       elsif(params[:desired_attribute] == 'Upto 20 lacs')
#         @ads = @ads.where(price: (0)..20)
#       elsif(params[:desired_attribute] == 'Upto 50 lacs')
#         @ads = @ads.where(price: (0)..50)
#       elsif(params[:desired_attribute] == 'Above 50 lacs')
#         @ads = @ads.where(price: (50)..5000)
#       end
#     end
#     @ads = @ads.global_search(params[:city]) if (params[:city].present?)
#     @ads = @ads.global_search(params[:color]) if (params[:color].present?)
#     @ads = @ads.global_search(params[:mileage]) if (params[:mileage].present?)
#     @ads = @ads.global_search(params[:car_make]) if (params[:car_make].present?)
#     @ads = @ads.global_search(params[:engine_capacity]) if (params[:engine_capacity].present?)
#     @ads = @ads.global_search(params[:engine_type]) if (params[:engine_type].present?)
#     @ads = @ads.global_search(params[:assembly_type]) if (params[:assembly_type].present?)
#     @ads = @ads.global_search(params[:transmission]) if (params[:transmission].present?)

#     return @ads
#   end
# end
