require "application_system_test_case"

describe "Drivers", :system do
  let(:driver) { drivers(:one) }

  it "visiting the index" do
    visit drivers_url
    assert_selector "h1", text: "Drivers"
  end

  it "creating a Driver" do
    visit drivers_url
    click_on "New Driver"

    fill_in "Name", with: @driver.name
    fill_in "Vin", with: @driver.vin
    click_on "Create Driver"

    assert_text "Driver was successfully created"
    click_on "Back"
  end

  it "updating a Driver" do
    visit drivers_url
    click_on "Edit", match: :first

    fill_in "Name", with: @driver.name
    fill_in "Vin", with: @driver.vin
    click_on "Update Driver"

    assert_text "Driver was successfully updated"
    click_on "Back"
  end

  it "destroying a Driver" do
    visit drivers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Driver was successfully destroyed"
  end
end
