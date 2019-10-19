require "test_helper"

describe PassengersController do
  let (:passenger) {
    Passenger.create name: "Tommy Pickles", phone_num: "954-879-3332"}
    
    describe "index" do
      
      it "" do
        # Your tests go here
        get passengers_path
        must_respond_with :success
      end
      
    end
    
    describe "show" do
      # Your tests go here
    end
    
    describe "new" do
      # Your tests go here
    end
    
    describe "create" do
      # Your tests go here
    end
    
    describe "edit" do
      # Your tests go here
    end
    
    describe "update" do
      # Your tests go here
    end
    
    describe "destroy" do
      # Your tests go here
    end
  end
  