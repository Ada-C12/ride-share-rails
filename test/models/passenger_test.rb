require "test_helper"

describe Passenger do
  let (:new_passenger) { Passenger.new(name: "Kari", phone_num: "111-111-1211") }
  
  it "can be instantiated" do
    # Assert
    expect(new_passenger.valid?).must_equal true
  end
  
  it "will have the required fields" do
    # Arrange
    new_passenger.save
    passenger = Passenger.first
    [:name, :phone_num].each do |field|
      # Assert
      expect(passenger).must_respond_to field
    end
  end
  
  describe "relationships" do
    it "can have many trips" do
      ### IDK WHY THIS DOES NOT WORK!!!!!
      assert(false)
      # Arrange
      new_passenger.save
      passenger = Passenger.first
      Driver.create(name: "some gal", vin: 123)
      Driver.create(name: "some guy", vin: 789)
      Trip.create(date: Time.now, passenger_id: passenger.id)
      Trip.create(date: Time.now + 5.days, passenger_id: passenger.id)
      updated_passenger = Passenger.first
      puts "\n\n\n\n\n\n"
      puts updated_passenger.trips.count
      puts updated_passenger.trips
      puts updated_passenger.attributes
      
      puts Trip.all
      puts Driver.all
      # Assert
      expect(updated_passenger.trips.count).must_be :>, 0
      updated_passenger.trips.each do |trip|
        expect(trip).must_be_instance_of Trip
      end
    end
  end
  
  describe "validations" do
    it "must have a name" do
      # Arrange
      new_passenger.name = nil
      
      # Assert
      expect(new_passenger.valid?).must_equal false
      expect(new_passenger.errors.messages).must_include :name
      expect(new_passenger.errors.messages[:name]).must_equal ["can't be blank"]
    end
    
    it "must have a phone number" do
      # Arrange
      new_passenger.phone_num = nil
      
      # Assert
      expect(new_passenger.valid?).must_equal false
      expect(new_passenger.errors.messages).must_include :phone_num
      expect(new_passenger.errors.messages[:phone_num]).must_equal ["can't be blank"]
    end
  end
  
  # Tests for methods you create should go here
end