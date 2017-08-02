class LocationsController < ApplicationController
  def new
    @location = Location.new
  end

  def create
    if location_does_not_exist(params)
      create_new_location(params)
    else
      set_existing_location(params)
    end
  end

  private
    def location_params
      params.require(:location).permit(:postal_code, :city, :country)
    end

    def location_does_not_exist(params)
      Location.find_by(postal_code: params['location']['postal_code']) == nil
    end

    def create_new_location(params)
      @location = Location.new(location_params)
      if @location.save
        redirect_to new_project_path(location_id: @location.id)
      else
        flash[:notice] = "Alert: Please input required fields."
        redirect_to new_location_path
      end
    end

    def set_existing_location(params)
      @location = Location.find_by(postal_code: params['location']['postal_code'])
      redirect_to new_project_path(location_id: @location.id)
    end
end
