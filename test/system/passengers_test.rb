require "application_system_test_case"

describe "Passengers", :system do
  let(:passenger) { passengers(:one) }

  it "visiting the index" do
    visit passengers_url
    assert_selector "h1", text: "Passengers"
  end

  it "creating a Passenger" do
    visit passengers_url
    click_on "New Passenger"

    fill_in "Name", with: @passenger.name
    fill_in "Phone num", with: @passenger.phone_num
    click_on "Create Passenger"

    assert_text "Passenger was successfully created"
    click_on "Back"
  end

  it "updating a Passenger" do
    visit passengers_url
    click_on "Edit", match: :first

    fill_in "Name", with: @passenger.name
    fill_in "Phone num", with: @passenger.phone_num
    click_on "Update Passenger"

    assert_text "Passenger was successfully updated"
    click_on "Back"
  end

  it "destroying a Passenger" do
    visit passengers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Passenger was successfully destroyed"
  end
end
