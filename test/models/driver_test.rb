require "test_helper"

describe Driver do
  let (:new_driver) {
    Driver.new(name: "Kari", vin: "123", active: true)
  }
  it "can be instantiated" do
    # Assert
    expect(new_driver.valid?).must_equal true
  end
  
  it "will have the required fields" do
    # Arrange
    new_driver.save
    driver = Driver.first
    [:name, :vin, :active].each do |field|
      
      # Assert
      expect(driver).must_respond_to field
    end
  end
  
  describe "relationships" do
    it "can have many trips" do
      # Arrange
      new_driver.save
      driver = Driver.first
      
      # Assert
      expect(driver.trips.count).must_be :>=, 0
      driver.trips.each do |trip|
        expect(trip).must_be_instance_of Trip
      end
    end
  end
  
  describe "validations" do
    it "must have a name" do
      # Arrange
      new_driver.name = nil
      
      # Assert
      expect(new_driver.valid?).must_equal false
      expect(new_driver.errors.messages).must_include :name
      expect(new_driver.errors.messages[:name]).must_equal ["can't be blank"]
    end
    
    it "must have a VIN number" do
      # Arrange
      new_driver.vin = nil
      
      # Assert
      expect(new_driver.valid?).must_equal false
      expect(new_driver.errors.messages).must_include :vin
      expect(new_driver.errors.messages[:vin]).must_equal ["can't be blank"]
    end
  end
  
  # Tests for methods you create should go here
  describe "custom methods" do
    before do
      @test_driver = Driver.create(name: "Kari", vin: "123", active: true)
      @new_passenger = Passenger.create(name: "sample passenger", phone_num: "sample number")
      
      @trip1 = Trip.create(date: Date.today, rating: 4, cost: 23.00, driver_id: @test_driver.id, passenger_id: @new_passenger.id)
      @trip2 = Trip.create(date: Date.today, rating: 2, cost: 13.00, driver_id: @test_driver.id, passenger_id: @new_passenger.id)
    end
    describe "average rating" do
      it "calculates accurate rating average" do
        expect(@test_driver.average_rating).must_equal 3
      end
    end
    
    describe "total earnings" do
      it "calculates accurate cost total" do
        expect(@test_driver.total_earnings).must_equal 36.00
      end
    end
    
    describe "toggle_active" do
      it "can go online - available (active:false)" do
        inactive_driver = Driver.create(name: "Kari", vin: "123", active: true)
        
        patch toggle_active_path(inactive_driver.id)
        
        completed_ = Driver.find_by(name: "An incomplete task")
        
        expect (completed_task.completed).must_be_kind_of ActiveSupport::TimeWithZone
        expect (completed_task.completed).must_be_close_to Time.now, 0.05
      end
      
      it "can go offline - unavailable (active:true)" do
        # Your code here
      end
    end
  end
end
