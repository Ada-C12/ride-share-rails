require "test_helper"

describe Trip do
  let(:new_trip) {
    driver_id = Driver.create(name: "Jane Doe", vin: "12345678").id
    passenger_id = Passenger.create(name: "John Doe", phone_num: "7654321").id
    Trip.create(cost: 12.46, date: Date.today, driver_id: driver_id, passenger_id: passenger_id)}

  it "can be instantiated" do
    expect(new_trip.valid?).must_equal true
  end

  it "will have the required fields" do
    new_trip.save
    trip = Trip.first
    [:cost, :date, :passenger_id, :driver_id].each do |field|
      expect(trip).must_respond_to field
    end
  end

  describe "relationships" do
    it 'can have a passenger and driver' do
    driver_id = Driver.create(name: "Jane Doe", vin: "12345678").id
    passenger_id = Passenger.create(name: "John Doe", phone_num: "7654321").id
    Trip.create(cost: 12.46, date: Date.today, driver_id: driver_id, passenger_id: passenger_id)
    new_trip = Trip.find_by(passenger_id: passenger_id)

    expect(new_trip.passenger.id).must_equal passenger_id
    expect(new_trip.passenger).must_be_instance_of Passenger
    expect(new_trip.driver.id).must_equal driver_id
    expect(new_trip.driver).must_be_instance_of Driver
    end
  end
end
