class UsersController < ApiController
  def index
    users = User.all.sample(4)
    render json: each_serialize(users)
  end
  def show
    user = User.all.sample
    render json: serialize(user)
  end
end