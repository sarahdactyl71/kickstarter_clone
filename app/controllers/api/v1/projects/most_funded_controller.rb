class Api::V1::Projects::MostFundedController < ApiController
  def index
    render json: Project.most_funded, serializer: MostFundedProjectSerializer
  end
end
