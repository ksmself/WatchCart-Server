class UsersController < ApiController
    before_action :set_user, only: [:show, :update]

    def show
        user = User.includes(:orders).find(params[:id])
        render json: serialize(user)
    end

    def update
        if @user.update_with_password(user_params)
            render json: true 
        else
            render json: {error: "현재 비밀번호를 다시 확인해주세요" }
        end 
    end
  
    private 
  
    def user_params
        params.require(:user).permit(:name, :email, :current_password, :password, :password_confirmation, :liked_movies, :orders)
    end 
  
    def set_user 
        @user = User.find(params[:id])
    end

    def permitted_query
        params[:q].permit(:status_eq)
    end
end
