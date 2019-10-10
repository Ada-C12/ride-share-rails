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
      get driver_path(valid_driver.id)
      must_respond_with :success
    end

    it "gives back a 404 response if they try an invalid id" do
      get driver_path("100000")
      must_respond_with :not_found
    end
  end

  describe "edit" do
    # Your tests go here
  end

  describe "update" do
    # Your tests go here
  end

  describe "new" do
    # Your tests go here
  end

  describe "create" do
    # Your tests go here
  end

  describe "destroy" do
    # Your tests go here
  end
end
