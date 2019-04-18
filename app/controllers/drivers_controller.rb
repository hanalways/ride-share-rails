class DriversController < ApplicationController
  def index
    @drivers = Driver.all
  end

  def show
    driver_id = params[:id]
    @driver = Driver.find_by(id: driver_id)
    unless @driver 
      redirect_to drivers_path 
      return
    end

    @trips = @driver.trips.all
  end

  def new
    @driver = Driver.new
  end

  def create
    @driver = Driver.new(driver_params) # will add car make and car model to the db

    saved = @driver.save

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
      redirect_to drivers_path
    end
  end

  def update
    driver_id = params[:id]
    @driver = Driver.find_by(id: driver_id)
    unless @driver
      redirect_to drivers_path
      return
    end

    if @driver.update(driver_params)
      redirect_to driver_path(@driver)
    else
      render :edit
    end
  end

  def destroy
    driver_id = params[:id]
    driver = Driver.find_by(id: driver_id)
    # if dirver is nil destroy all th instances of trip
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
