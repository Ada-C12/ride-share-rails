require "test_helper"

describe Passenger do
  let (:new_passenger) {
  Passenger.new(name: "Kari", phone_num: "111-111-1211")
}
it "can be instantiated" do
  expect(new_passenger.valid?).must_equal true
end

it "will have the required fields" do
  
  new_passenger.save
  passenger = Passenger.first
  [:name, :phone_num].each do |field|
    
    expect(passenger).must_respond_to field
  end
end

describe "relationships" do
  it "can have many trips" do
    
    new_passenger.save
    passenger = Passenger.first
    
    expect(passenger.trips.count).must_be :>=, 0
    passenger.trips.each do |trip|
      expect(trip).must_be_instance_of Trip
    end
  end
end

describe "validations" do
  it "must have a name" do
    
    new_passenger.name = nil
    
    expect(new_passenger.valid?).must_equal false
    expect(new_passenger.errors.messages).must_include :name
    expect(new_passenger.errors.messages[:name]).must_equal ["can't be blank"]
  end
  
  it "must have a phone number" do
    
    new_passenger.phone_num = nil
    
    expect(new_passenger.valid?).must_equal false
    expect(new_passenger.errors.messages).must_include :phone_num
    expect(new_passenger.errors.messages[:phone_num]).must_equal ["can't be blank"]
  end
end

describe "custom methods" do
  describe "total_spent" do
    it "can calculate total spent on trips for a passenger" do
      @driver = Driver.create(name: "Kari", vin: "123", active: false, car_make: "Cherry", car_model: "DR5")
      
      @passenger = Passenger.create(name: "Kari", phone_num: "111-111-1211")
      
      Trip.create(driver_id: @driver.id, passenger_id: @passenger.id, rating: 3, date: Date.today, cost: 250)
      Trip.create(driver_id: @driver.id, passenger_id: @passenger.id, rating: 4, date: Date.today, cost: 350)
      Trip.create(driver_id: @driver.id, passenger_id: @passenger.id, rating: 5, date: Date.today, cost: 200.25)
      
      expect(@passenger.total_spent).must_equal "800.25"
    end
  end
end
end
