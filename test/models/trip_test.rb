require "test_helper"

describe Trip do
  it "can be instantiated" do
    passenger = Passenger.create(name: "Emmanlle Breiterg", phone_num: "(707) 341-7157")
    driver = Driver.create(name: "Dr. Ken Berge", vin: "SXMMLZX8XGDN7L7TM", available: true)
    trip = Trip.create(driver_id: driver.id, passenger_id: passenger.id, date: Date.today, cost: 10.00)
    
    expect(trip.valid?).must_equal true
  end
  
  it "will have the required fields" do
    passenger = Passenger.create(name: "Emmanlle Breiterg", phone_num: "(707) 341-7157")
    driver = Driver.create(name: "Dr. Ken Berge", vin: "SXMMLZX8XGDN7L7TM", available: true)
    trip = Trip.create(driver_id: driver.id, passenger_id: passenger.id, date: Date.today, cost: 10.00)
    
    trip.save
    trip = Trip.first
    [:passenger_id, :driver_id, :rating, :cost, :date].each do |field|
      
      # Assert
      expect(trip).must_respond_to field
    end
  end
end

# describe "relationships" do
#   it "can have many trips" do

#     end
#   end
# end


# # Tests for methods you create should go here

# end
