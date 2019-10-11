require "test_helper"

describe Passenger do
  let (:new_passenger) {
    Passenger.new(name: "Kari", phone_num: "111-111-1211")
  }
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
      # Arrange
      new_passenger.save
      passenger = Passenger.first
      
      
      # Assert
      expect(passenger.trips.count).must_be :>=, 0
      passenger.trips.each do |trip|
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
  
  describe "total_charged" do
    it "can calculate the total charged for a passenger" do
      passenger = Passenger.create(name: "test person", phone_num: "1")
      driver = Driver.create(name: "test driver", vin: "111")
      
      trip_one = Trip.create(date: Time.now, rating: nil, cost: 1, driver_id: driver.id, passenger_id: passenger.id)
      trip_two = Trip.create(date: Time.now, rating: nil, cost: 2, driver_id: driver.id, passenger_id: passenger.id)
      
      expect(passenger.total_charged).must_equal 3
    end
    
    it "returns 0 if there are no trips" do
      passenger = Passenger.create(name: "test person", phone_num: "1")
      
      expect(passenger.total_charged).must_equal 0
    end
  end
  
  describe "avatar image" do
    it "must return an image link" do
      passenger = Passenger.create(name: "M. Random", phone_num: "111.555.111")
      
      avatar_url = passenger.avatar_image
      
      url_beginning = !!(avatar_url =~ /\Ahttps:\/\//)
      url_ending = !!(avatar_url =~ /\.png\Z/)
      
      expect(url_beginning).must_equal true
      expect(url_ending).must_equal true
    end
  end
  
end

