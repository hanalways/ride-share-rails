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
    let(:driver_params) {
    {
      driver: {
        name: "test driver",
        },
    
      }
    }

    it "can update data on existing driver" do 
      new_driver.assign_attributes(driver_params[:driver])
      expect(new_driver).must_be :valid?

      patch driver_path(new_driver), params: driver_params

      must_respond_with :redirect
      expect(new_driver.name).must_equal(driver_params[:driver][:name])
    end

    it "redirects to root if given invalid id" do 
      patch driver_path(-1), params: driver_params 
      must_redirect_to drivers_path
    end

    it "validates parameters correctly" do 
      new_driver.name = nil
      expect(new_driver.save).must_equal false
      expect(new_driver.valid?).must_equal false
      expect(new_driver.errors.messages[:name][0]).must_equal "can't be blank"
    end
  end

  describe "new" do
    it "returns status code 200" do 
      get new_driver_path
      must_respond_with :ok
    end
  end

  describe "create" do
    it "creates a new driver" do 
      driver_data = {
        driver: {
          name: "newest driver",
          vin: "random vin",
          car_make: "big company",
          car_model: "sedan",
        },
      }

      expect {
        post drivers_path, params: driver_data 
      }.must_change "Driver.count", +1

      must_respond_with :redirect 
      must_redirect_to drivers_path
    end

    it "validates parameters correctly" do 
      driver = Driver.new
      expect(driver.valid?).must_equal false
      expect(driver.errors.messages[:name][0]).must_equal "can't be blank"
      expect(driver.errors.messages[:vin][0]).must_equal "can't be blank"
      expect(driver.errors.messages[:car_make][0]).must_equal "can't be blank"
      expect(driver.errors.messages[:car_model][0]).must_equal "can't be blank"
    end
  end

  describe "destroy" do
    it "removes the driver from the database" do 
      deleted_driver = Driver.create!(
        name: "deleted driver",
        vin: "random vin",
        car_make: "car",
        car_model: "car",
      )
      expect {
        delete driver_path(deleted_driver)
      }.must_change "Driver.count", -1

      must_respond_with :redirect
      must_redirect_to drivers_path 
    end
  end
end
