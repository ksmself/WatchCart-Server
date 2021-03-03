class V1::UsersController < V1::BaseController
  def index
    render json: each_serialize(User.all.sample(4), serializer_name: :UserSerializer, context: {current_api_user: current_api_user})
  end
end