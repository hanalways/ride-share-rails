class DriversController < ApplicationController
  def index
    @drivers = Driver.all
  end

  def show
    driver_id = params[:id]
    @driver = Driver.find_by(id: driver_id)

    if @driver.nil?
      head :not_found
    end
  end

  def new
    @driver = Driver.new
  end

  def create
    @driver = Driver.new(driver_params) # will add car make and car model to the db

    saved = @driver.save

    if saved
      redirect_to trips_path #assuming trips is main page ?
    else
      render :new
    end
  end

  def edit
    driver_id = params[:id]
    @driver = Driver.find_by(driver_id)

    if @driver.nil?
      redirect_to trips_path
    end
  end

  def update
    driver_id = params[:id]
    driver = Driver.find_by(driver_id)

    driver.update(driver_params)
    redirect_to trips_path(task.id)
  end

  def destroy
    driver_id = params[:id]
    driver = Driver.find_by(driver_id)

    unless driver
      head :not_found
      return
    end

    driver.destroy
    redirect_to trips_path
  end

  private

  def driver_params
    return params.require(:driver).permit(
             :name,
             :vin
           )
  end
end
