class Api::V1::Locations::LocationWithMostProjectsController < ApiController
  def show
    render json: Location.top_5_most_active, each_serializer: LocationSerializer
  end

end
