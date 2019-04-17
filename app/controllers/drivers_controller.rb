class DriversController < ApplicationController
  def index
    @drivers = Driver.all
  end

  def show
    driver_id = params[:id]
    @driver = Driver.find_by(id: driver_id)
    @trips = @driver.trips.all

    if @driver.nil?
      head :not_found
    end
  end

  def new
    @driver = Driver.new
  end

  def create
    @drivers = Driver.new(driver_params) # will add car make and car model to the db

    saved = @drivers.save

    if saved
      redirect_to drivers_path
    else
      render :new
    end
  end

  def edit
    driver_id = params[:id]
    @driver = Driver.find_by(id: driver_id)

    if @driver.nil?
      redirect_to trips_path
    end
  end

  def update
    driver_id = params[:id]
    driver = Driver.find_by(id: driver_id)

    driver.update(driver_params)
    redirect_to trips_path(driver.id)
  end

  def destroy
    driver_id = params[:id]
    driver = Driver.find_by(id: driver_id)

    driver.destroy
    redirect_to drivers_path
  end

  private

  def driver_params
    return params.require(:driver).permit(
             :name,
             :vin,
             :status,
             :car_make,
             :car_model
           )
  end
end
