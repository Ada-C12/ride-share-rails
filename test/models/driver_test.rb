require "test_helper"

describe Driver do

  let (:new_driver) {
    Driver.new(name: "Kari", vin: "123", available: true)
  }
  it "can be instantiated" do
    # Assert
    expect(new_driver.valid?).must_equal true
  end

  it "will have the required fields" do
     # Arrange
     new_driver.save
     driver = Driver.first
     [:name, :vin, :available].each do |field|

     # Assert
       expect(driver).must_respond_to field
     end
   end
 
   describe "relationships" do
     it "can have many trips" do
       # Arrange
       new_driver.save
       driver = Driver.first

       new_passenger = Passenger.create(name: "Kari", phone_num: "111-111-1211")
      trip_1 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 5, cost: 1234)
      trip_2 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 3, cost: 6334)
 
       # Assert
       expect(new_driver.trips.count).must_equal 2
       new_driver.trips.each do |trip|
         expect(trip).must_be_instance_of Trip
       end
     end
   end
 

  # Tests for methods you create should go here
  describe "custom methods" do
    describe "average rating" do
      # Your code here
    end

    describe "total earnings" do
      # Your code here
    end
    
    describe "can go offline" do
      # Your code here
    end
  end
end
