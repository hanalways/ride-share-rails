require "test_helper"

describe PassengersController do
  let (:new_passenger) {
    Passenger.new(name: "Hana", phone_num: "206-555-5555")
  }

  describe "index" do
    it "renders without crashing" do
      get passengers_path

      must_respond_with :ok
    end

    it "renders even if there are no passengers" do
      Passenger.destroy_all

      get passengers_path
      must_respond_with :ok
    end
  end

  describe "show" do
    it "renders for an existing passenger" do 
      # get passenger_path(passenger.id)

      # must_respond_with :ok
    end
  end

  describe "edit" do
    # Your tests go here
  end

  describe "update" do
    # Your tests go here
  end

  describe "new" do
    # Your tests go here
  end

  describe "create" do
    # Your tests go here
  end

  describe "destroy" do
    # Your tests go here
  end
end
