require "test_helper"

describe PassengersController do
  let (:passenger1) { Passenger.create( name: "Ned Flanders", phone_num: "206-123-1234") }
  let (:passenger_hash) {{ passenger: { name: "Homer Simpson", phone_num: "425-123-1234" } }}
  
  describe "index" do
    it "can go to Passengers/index" do
      get passengers_path
      must_respond_with :success
    end
  end
  
  describe "show" do
    it "can go to Passengers/:id/show for valid id" do
      passenger1
      get passenger_path(id: passenger1.id)
      must_respond_with :success
    end
    
    it "redirect to nope_path if invalid id" do
      get passenger_path(id: -666)
      must_redirect_to nope_path(msg: "No such passenger exists!")
    end
  end
  
  describe "new" do
    it "can go to Passengers/new.html" do
      get new_passenger_path
      must_respond_with :success
    end
  end
  
  describe "create" do
    it "can create new Passenger, given good inputs, and go to show.html" do
      expect {post passengers_path, params: passenger_hash}.must_change "Passenger.count", 1
      new_passenger = Passenger.last
      must_redirect_to passenger_path(id: new_passenger.id)
      assert (new_passenger.name == passenger_hash[:passenger][:name])
      assert (new_passenger.phone_num == passenger_hash[:passenger][:phone_num])
    end
    
    it "Bad inputs will fail validations, and user will stay on page" do
      bad_names = [nil, "", "    "]
      
      bad_names.each do |bad_name|
        bad_params = { passenger: {name: bad_name, phone_num: "4251231234"} } 
        expect { post passengers_path, params: bad_params }.must_differ "Passenger.count", 0
        must_respond_with 200
      end
      
      ### FUTURE IDEA: VALIDATE AGAINST THESE... 
      # more_bad_phone_nums = ["garbage", "!!!!!", "123"]
      
      bad_phone_nums = [nil, "", "    "]
      bad_phone_nums.each do |bad_phone_num|
        bad_params = { passenger: {name: "jerky jerkface", phone_num: bad_phone_num} } 
        expect {post passengers_path, params: bad_params }.must_differ "Passenger.count", 0
        must_respond_with 200
      end
      
    end
  end
  
  describe "edit" do
    it "" do
      get edit_passenger_path(id: passenger1.id)
      must_respond_with :success
    end
    
    it "redirects to nope_path if bad id" do
      get edit_passenger_path(id: -666)
      must_redirect_to nope_path(msg: "Cannot edit a non-existent passenger!")
    end
  end
  
  describe "update" do
    it "" do
      ###
    end
  end
  
  describe "destroy" do
    it "will destroy passenger obj and redirect to passengers index pg" do
      passenger1
      expect {delete passenger_path(id: passenger1.id)}.must_differ "Passenger.count", -1
      must_redirect_to passengers_path
    end
    
    it "will redirect to nope_path if bad id given" do
      delete passenger_path(id: -666)
      must_redirect_to nope_path(msg: "Cannot destroy a non-existent passenger record")
    end
  end
end
