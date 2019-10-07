require "test_helper"

describe HomepagesController do
  it "can get the homepage" do
    get root_path
    
    must_respond_with :success
  end
  
  it "can get to drivers/index" do
    get drivers_path
    must_respond_with :success
  end
  
  it "can get to passengers/index" do
    get passengers_path
    must_respond_with :success
  end
  
  it "can get to trips/index" do
    get trips_path
    must_respond_with :success
  end
end
