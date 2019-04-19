class TripsController < ApplicationController
  def index
    @trips = Trip.all
  end

  def show
    id = params[:id]
    @trip = Trip.find_by(id: id)

    unless @trip
      redirect_to trips_path
      return 
    end
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
    @trip.cost = 10
    if @trip.save
      @trip.driver.update(status: false)
      @trip.passenger.update(on_trip: true)

      redirect_to passenger_path(@trip[:passenger_id])
    else
      render :new
    end
  end

  def edit
    @trip = Trip.find_by(id: params[:id])

    unless @trip
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    @trip = Trip.find_by(id: params[:id])
    if !@trip.nil?
      if @trip.update(trip_params)
        redirect_to trip_path(@trip.id)
      else
        render :edit
      end
    else
      redirect_to trips_path
    end
  end

  def update_rating
    @trip = Trip.find_by(id: params[:id])
    if !@trip.nil?
      if @trip.update(trip_params)
        @trip.driver.update(status: true)
        redirect_to trip_path(@trip.id)
      else
        render :show
      end
    else
      redirect_to trips_path
    end
  end

  def destroy
    @trip = Trip.find_by(id: params[:id])
    if @trip
      @trip.driver.update(status: true)
      @trip.passenger.update(on_trip: false)
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
