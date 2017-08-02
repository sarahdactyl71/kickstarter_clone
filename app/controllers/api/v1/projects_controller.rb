class Api::V1::ProjectsController < ApiController
  def index
    render json: Project.all, each_serializer: ProjectSerializer
  end

  def show
    render json: Project.find(params[:id]), each_serializer: ProjectSerializer
  end
end
