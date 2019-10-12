require "test_helper"

describe Driver do

  let (:new_driver) {
    Driver.new(name: "somthing", vin: "123", available: true)
  }

  let(:new_passenger) {
    Passenger.create(name: "Hhelloo", phone_num: "975980")
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
      let (:driver) {
        Driver.create(name: "Driver", vin: "123", active: nil)
      }
      let(:passenger) {
        Passenger.create(name: "Haha Me", phone_num: "Nonono")
      }
      let(:trip_1) {
        Trip.create(passenger_id: passenger.id, driver_id: driver.id, date: Date.today, cost: "1000", rating: "5")
      }
      let(:trip_2) {
        Trip.create(passenger_id: passenger.id, driver_id: driver.id, date: Date.today, cost: "2000", rating: "4")
      }

    describe "average rating" do
      # Your code here




    end
  end

    describe "total earnings" do
      # Your code here
      it "can calculate the total earning of this driver when the driver made at least one trip" do
        it "calculates the total money spent per passenger" do
          driver_test = Driver.create(name: "Test Driver!", vin: "FSD34534SLDK", available: true)
          Trip.create(date: Date.today, rating: 5, cost: 1050, passenger_id: passenger_test.id, driver_id: driver_test.id)
          Trip.create(date: Date.today, rating: 5, cost: 2050, passenger_id: passenger_test.id, driver_id: driver_test.id)
  
          driver_test.reload
          
          expect(passenger_test.total_money_spent).must_equal 31.00
      end
    end

    describe "can go offline" do
      # Your code here
        it "can switch the active status of driver to true which means the driver is not available to accept a trip" do
          new_driver.update(available: true)

          expect(new_driver.available).must_equal true
          new_driver.go_offline

          find_driver = Driver.find_by(id: new_driver.id)
          expect(find_driver.available).must_equal false
        end
    end
  end
end


