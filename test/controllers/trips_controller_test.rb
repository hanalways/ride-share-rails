require "test_helper"

describe TripsController do
  let(:passenger) {
    Passenger.create!(
      name: "test passenger",
      phone_num: "555-555-5555"
    )
  }
  let(:driver) {
    Driver.create!(
      name: "test driver",
      vin: "test vin",
      car_make: "test car",
      car_model: "test model"
    )
  }
  let(:trip) {
    Trip.create!(
      driver_id: driver.id,
      passenger_id: passenger.id,
      date: Date.today,
      rating: 3,
      cost: 10.75
    )
  }
  describe "show" do
    it "can show a trip with a valid id" do 
      get trip_path(trip.id)
      must_respond_with :ok
    end

    it "redirects if given an invalid trip id" do
      get trip_path(-1)
      must_respond_with :redirect
    end
  end

  describe "edit" do
    it "can get the edit page for an existing trip" do 
      get edit_trip_path(trip)
      must_respond_with :ok
    end

    it "will respond with a redirect when attempting to edit a nonexistent trip" do 
      get edit_trip_path(-1)
      must_respond_with :redirect
    end
  end

  describe "update" do
    # Your tests go here
  end

  describe "create" do
    # Your tests go here
  end

  describe "destroy" do
    # Your tests go here
  end
end
