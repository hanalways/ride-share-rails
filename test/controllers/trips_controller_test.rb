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
    let(:trip_params) {
      {
        trip: {
         rating: 5,
        },
      }
    }

    it "can update data on an existing trip" do
    skip  
    end

    it "redirects to root if given invalid id" do 
    skip
    end

    it "validates the parameters correctly" do
    skip
    end
  end

  describe "create" do
    it "creates a new trip" do 
      trip_data = {
        trip: {
          driver_id: driver.id,
          passenger_id: passenger.id,
          date: Date.today,
          rating: 3,
          cost: 10.75,
        },
      }

      expect {
        patch trip_path(trip.id), params: trip_data
      }.must_change "Trip.count", +1

      must_respond_with :redirect
    end
  end

  describe "destroy" do
    it "removes trip from database" do 
      deleted_trip = Trip.create!(
        passenger_id: Passenger.all.sample.id,
        driver_id: Driver.all.sample.id,
        date: Date.today,
        rating: 3,
        cost: 20.50
      )

      expect {
        delete trip_path(deleted_trip)
      }.must_change "Trip.count", -1

      must_respond_with :redirect
      must_redirect_to root_path

      after_trip = Trip.find_by(id: deleted_trip.id)
      expect(after_trip).must_be_nil
    end
  end
end