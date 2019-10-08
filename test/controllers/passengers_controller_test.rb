require "test_helper"

describe PassengersController do
  # let (:passenger1) { Passenger.create (name: "J. G. Wentworth", phone_num: "1-800-cash-now") }
  
  describe "index" do
    it "can go to Passengers/index" do
      get passengers_path
      must_respond_with :success
    end
  end
  
  describe "show" do
    it "can go to Passengers/:id/show for valid id" do
      passenger1
      get passenger_path(id: Passenger.first.id)
      must_respond_with :success
    end
    
    it "redirect to homepage if invalid id" do
      get passenger_path(id: -666)
      must_redirect_to nope_path
    end
  end
  
  describe "new" do
    it "can go to Passengers/new.html" do
      get new_passenger_path
      must_respond_with :success
    end
    
    it "Given bad args, will fail validations, and stay on page" do
      bad_names = [nil, "", "    "]
      bad_phone_nums = ["garbage", "!!!!!", "123"]
      
      bad_names.each do |bad_name|
        bad_passenger = Passenger.create(name: bad_name, phone_num: 4251231234)
        refute(bad_passenger)
        # must_respond_with :success
      end
    end
  end
  
  describe "create" do
    it "will make new Passenger obj correctly with good args" do
    end
    
    it "will not make Passenger obj and give errors with bad args" do
    end
  end
  
  #   describe "edit" do
  #     # Your tests go here
  #   end
  
  #   describe "update" do
  #     # Your tests go here
  #   end
  
  #   describe "destroy" do
  #     # Your tests go here
  #   end
end
