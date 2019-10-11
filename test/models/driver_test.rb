require "test_helper"

describe Driver do
  let (:test_driver) {
    Driver.new(name: "Kari", vin: "123", available: true)
  }
  it "can be instantiated" do
    # Assert
    expect(test_driver.valid?).must_equal true
  end


  # Tests for methods you create should go here
  describe "custom methods" do
    describe "average rating" do
      # Your code here
    end

    describe "total earnings" do
      # Your code here
    end

    describe "can go online" do
      # Your code here
    end

    describe "can go offline" do
      # Your code here
    end
  end
end
