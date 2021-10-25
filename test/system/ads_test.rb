require "application_system_test_case"

class AdsTest < ApplicationSystemTestCase
  setup do
    @ad = ads(:one)
  end

  test "visiting the index" do
    visit ads_url
    assert_selector "h1", text: "Ads"
  end

  test "creating a Ad" do
    visit ads_url
    click_on "New Ad"

    fill_in "Assembly type", with: @ad.assembly_type
    fill_in "Car make", with: @ad.car_make
    fill_in "City", with: @ad.city
    fill_in "Color", with: @ad.color
    fill_in "Description", with: @ad.description
    fill_in "Engine capacity", with: @ad.engine_capacity
    fill_in "Engine type", with: @ad.engine_type
    fill_in "Mileage", with: @ad.mileage
    fill_in "Price", with: @ad.price
    fill_in "Transmission", with: @ad.transmission
    click_on "Create Ad"

    assert_text "Ad was successfully created"
    click_on "Back"
  end

  test "updating a Ad" do
    visit ads_url
    click_on "Edit", match: :first

    fill_in "Assembly type", with: @ad.assembly_type
    fill_in "Car make", with: @ad.car_make
    fill_in "City", with: @ad.city
    fill_in "Color", with: @ad.color
    fill_in "Description", with: @ad.description
    fill_in "Engine capacity", with: @ad.engine_capacity
    fill_in "Engine type", with: @ad.engine_type
    fill_in "Mileage", with: @ad.mileage
    fill_in "Price", with: @ad.price
    fill_in "Transmission", with: @ad.transmission
    click_on "Update Ad"

    assert_text "Ad was successfully updated"
    click_on "Back"
  end

  test "destroying a Ad" do
    visit ads_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ad was successfully destroyed"
  end
end
