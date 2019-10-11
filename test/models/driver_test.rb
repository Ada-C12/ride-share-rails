require "test_helper"

describe Driver do

  let (:driver_test) {
    Driver.new(name: "Test Driver", vin: "123", available: true)
  }
  it "can be instantiated" do
    # Assert
    expect(driver_test.valid?).must_equal true
  end

  it "will have the required fields" do
     # Arrange
     driver_test.save
     driver = Driver.first
     [:name, :vin].each do |field|
 
     # Assert
       expect(driver).must_respond_to field
     end
   end
 
   describe "relationships" do
     it "can have many trips" do
       # Arrange
       driver_test.save
       driver = Driver.first
 
       # Assert
       expect(driver.trips.count).must_be :>, 0
       driver.trips.each do |trip|
         expect(trip).must_be_instance_of Trip
       end
     end
   end
 



#   # Tests for methods you create should go here
#   describe "custom methods" do
#     describe "average rating" do
#       # Your code here
#     end

#     describe "total earnings" do
#       # Your code here
#     end

#     describe "can go online" do
#       # Your code here
#     end

#     describe "can go offline" do
#       # Your code here
#     end
#   end
end
