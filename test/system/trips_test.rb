require "application_system_test_case"

describe "Trips", :system do
  let(:trip) { trips(:one) }

  it "visiting the index" do
    visit trips_url
    assert_selector "h1", text: "Trips"
  end

  it "creating a Trip" do
    visit trips_url
    click_on "New Trip"

    fill_in "Cost", with: @trip.cost
    fill_in "Date", with: @trip.date
    fill_in "Driver", with: @trip.driver_id
    fill_in "Passenger", with: @trip.passenger_id
    fill_in "Rating", with: @trip.rating
    click_on "Create Trip"

    assert_text "Trip was successfully created"
    click_on "Back"
  end

  it "updating a Trip" do
    visit trips_url
    click_on "Edit", match: :first

    fill_in "Cost", with: @trip.cost
    fill_in "Date", with: @trip.date
    fill_in "Driver", with: @trip.driver_id
    fill_in "Passenger", with: @trip.passenger_id
    fill_in "Rating", with: @trip.rating
    click_on "Update Trip"

    assert_text "Trip was successfully updated"
    click_on "Back"
  end

  it "destroying a Trip" do
    visit trips_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Trip was successfully destroyed"
  end
end
