require "test_helper"

describe DriversController do
  describe "index" do
    it "gives back a successful response" do
      get drivers_path
      must_respond_with :success
    end

    it "can get the root path" do
      get root_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "gives back a successful response" do
      valid_driver = Driver.create(name: "James Franco", vin:"425449888")
      get drivers_path(valid_driver.id)
      must_respond_with :success
    end

    it "gives back a 404 response if they try an invalid id" do
      get driver_path("100000")
      must_respond_with :not_found
    end
  end

  describe "edit" do
    it "can get the edit page for an existing driver" do
      second_driver = Driver.create(name: "Seth Rogan", vin:"425449888")
      get edit_driver_path(second_driver.id)
      must_respond_with :success
    end

    it "will respond with not_found when attempting to edit a nonexistant task" do
      get edit_driver_path(-1)
      must_respond_with :not_found
    end
  end

  describe "update" do
    before do
      @existing_driver = Driver.create(name: "Drew Barrymore", vin: "425449888")
      @updated_driver_form_data = {
        driver: {
          name: "Adam Sandler",
          vin: "345920292",
        }
      }
    end

    it "can update an existing driver" do
      patch driver_path(@existing_driver.id), params: @updated_driver_form_data

      expect(Driver.find_by(id: @existing_driver.id).name).must_equal "Adam Sandler"
      expect(Driver.find_by(id: @existing_driver.id).vin).must_equal "345920292"
    end

    it "can't update an existing driver giving wrong parameters" do
      wrong_driver_form_data = {
        driver: {
          names: "Becca",
          vims: "345920292",
        }
      }
      patch driver_path(@existing_driver.id), params: wrong_driver_form_data

      expect(Driver.find_by(id: @existing_driver.id).name).must_equal "Drew Barrymore"
      expect(Driver.find_by(id: @existing_driver.id).vin).must_equal "425449888"
    end

    it "will respond with not_found if given an invalid id" do
      patch driver_path(-1), params: @updated_driver_form_data
      must_respond_with :not_found
    end
  end

  describe "new" do
    it "can get the new driver page" do
      get new_driver_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new driver" do
      driver_info = {
        driver: {
          name: "Chris",
          vin: "4254449878",
        },
      }
      expect {
        post drivers_path, params: driver_info
      }.must_change "Driver.count", 1

      new_driver = Driver.find_by(name: driver_info[:driver][:name])
      expect(new_driver.name).must_equal driver_info[:driver][:name]
      expect(new_driver.vin).must_equal driver_info[:driver][:vin]
    end
  end

  describe "destroy" do
    before do
      @driver_info = {
        driver: {
          name: "Chris",
          vin: "4254449878",
        },
      }
    end

    it "can delete a driver" do
      old_driver = Driver.create(@driver_info[:driver])
      expect {
        delete driver_path(old_driver.id)
      }.must_change "Driver.count", 1
    end

    it "will respond with not_found if given an invalid id" do
      patch driver_path(-1)
      must_respond_with :not_found
    end
  end

  describe "toggle_status" do  
    it "will set the driver status to active if inactive" do
      driver = Driver.create(name: "Kim Possible", vin: "425449888", active: false)
      params = {
        driver: {
          active: true,
        }
      }
      
      patch "/drivers/#{driver.id}/toggle_status", params: params
      
      driver.reload

      expect(driver.active).must_equal true
    end

    it "will set the driver status to inactive if active" do
      driver = Driver.create(name: "Kim Possible", vin: "425449888", active: true)
      params = {
        driver: {
          active: false,
        }
      }
      
      patch "/drivers/#{driver.id}/toggle_status", params: params
      
      driver.reload

      expect(driver.active).must_equal false
    end

  end

end
