require "test_helper"

class AdsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ad = ads(:one)
  end

  test "should get index" do
    get ads_url
    assert_response :success
  end

  test "should get new" do
    get new_ad_url
    assert_response :success
  end

  test "should create ad" do
    assert_difference('Ad.count') do
      post ads_url, params: { ad: { assembly_type: @ad.assembly_type, car_make: @ad.car_make, city: @ad.city, color: @ad.color, description: @ad.description, engine_capacity: @ad.engine_capacity, engine_type: @ad.engine_type, mileage: @ad.mileage, price: @ad.price, transmission: @ad.transmission } }
    end

    assert_redirected_to ad_url(Ad.last)
  end

  test "should show ad" do
    get ad_url(@ad)
    assert_response :success
  end

  test "should get edit" do
    get edit_ad_url(@ad)
    assert_response :success
  end

  test "should update ad" do
    patch ad_url(@ad), params: { ad: { assembly_type: @ad.assembly_type, car_make: @ad.car_make, city: @ad.city, color: @ad.color, description: @ad.description, engine_capacity: @ad.engine_capacity, engine_type: @ad.engine_type, mileage: @ad.mileage, price: @ad.price, transmission: @ad.transmission } }
    assert_redirected_to ad_url(@ad)
  end

  test "should destroy ad" do
    assert_difference('Ad.count', -1) do
      delete ad_url(@ad)
    end

    assert_redirected_to ads_url
  end
end
