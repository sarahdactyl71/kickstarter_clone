class Api::V1::Locations::LocationWithMostProjectsController < ApiController
  def show
    render json: Location.most_active, serializer: LocationSerializer
  end

end
