require "test_helper"

describe DriversController do
  let(:new_driver) {
    Driver.create!(
      name: "test driver", 
      vin: "test vin",
      car_make: "honda",
      car_model: "accord"
    )
  }

  describe "index" do
    it "can get index" do
      get drivers_path

      must_respond_with :success
    end

    it "renders even if there are no drivers" do
      Driver.destroy_all

      get drivers_path
      must_respond_with :ok
    end
  end

  describe "show" do
    it "shows driver details with valid id" do 
      get driver_path(new_driver.id)

      must_respond_with :ok
    end

    it "will redirect with an invalid driver id" do
      get driver_path(-1)

      must_respond_with :redirect
    end
  end

  describe "edit" do
    it "gets to edit page for an existing driver" do 
      get edit_driver_path(new_driver.id)
      must_respond_with :ok
    end

    it "will respond with a redirect when attempting to edit a nonexistent path" do 
      get edit_driver_path(-1)
      must_redirect_to drivers_path
    end
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
