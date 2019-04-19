class TripsController < ApplicationController
  def index
    @trips = Trip.all
  end

  def show
    id = params[:id]
    @trip = Trip.find(id)
  end

  def new
    if params[:passenger_id]
      passenger = Passenger.find_by(id: params[:passenger_id])
      @trip = Trip.new
    else
      @trip = Trip.new
    end
  end

  def create
    @trip = Trip.new
    @trip.passenger = Passenger.find(params[:passenger_id])
    @trip.driver = select_driver

    @trip.date = Date.today.to_s
    @trip.cost = 0
    if @trip.save
      @trip.driver.update(status: false)

      redirect_to passenger_path(@trip[:passenger_id])
    else
      render :new
    end
  end

  def edit
    @trip = Trip.find_by(id: params[:id])
  end

  def update
    @trip = Trip.find_by(id: params[:id])
    if @trip.update(trip_params)
      redirect_to passenger_path(@trip[:passenger_id])
    else
      render :edit
    end
  end

  def destroy
    @trip = Trip.find_by(id: params[:id])
    if @trip
      @trip.destroy
    end
    redirect_to trips_path
  end

  private

  def trip_params
    params.require(:trip).permit(:id, :date, :rating, :cost, :driver_id, :passenger_id)
  end

  def select_driver
    drivers = Driver.all
    drivers_available = drivers.select { |driver| driver.status == true }
    return drivers_available.sample
  end
end
