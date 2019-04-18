require "test_helper"

describe PassengersController do
  let (:new_passenger) {
    Passenger.create!(name: "Hana Clements", phone_num: "206-555-5555")
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
      get passenger_path(new_passenger.id)

      must_respond_with :ok
    end

    it "redirects if given an invalid passenger id" do 
      get passenger_path(-1)

      must_respond_with :redirect
    end
  end

  describe "edit" do
    it "can get the edit page for an existing passenger" do 
      get edit_passenger_path(new_passenger.id)
      must_respond_with :success
    end

    it "will respond with a redirect when attempting to edit a nonexistent path" do 
      get edit_passenger_path(-1)
      must_redirect_to passengers_path
    end
  end

  describe "update" do
    let(:passenger_params) {
      {
        passenger: {
          name: "test passenger",
        },
      }
    }

    it "can update data on existing passenger" do 
      # Assume
      new_passenger.assign_attributes(passenger_params[:passenger])
      expect(new_passenger).must_be :valid?
      
      # Act
      patch passenger_path(new_passenger), params: passenger_params
      
      # Assert
      must_respond_with :redirect
      expect(new_passenger.name).must_equal(passenger_params[:passenger][:name])
    end

    it "redirects to root if given invalid id" do
      patch passenger_path(-1), params: passenger_params 
      must_redirect_to passengers_path
    end

    it "validates parameters correctly" do
      new_passenger.name = nil
      expect(new_passenger.save).must_equal false
      expect(new_passenger.valid?).must_equal false
      expect(new_passenger.errors.messages[:name][0]).must_equal "can't be blank"
    end
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
