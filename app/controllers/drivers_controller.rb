class DriversController < ApplicationController
  def show
    driver_id = params[:id]
    @driver = Driver.find_by(id: driver_id)
  end
end
