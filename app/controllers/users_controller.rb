class UsersController < ApiController
    before_action :set_user, only: [:show, :update]

    def show
        render json: serialize(@user)
    end

    # def update 
    #     # params
    #       # name, email, curPassword, newPassword
    #     # curPassword와 user의 비밀번호가 일치하면
    #       # name 변경
    #       # newPassword가 ''이 아니면 변경 
    #       if @user["password"] == user_params[:curPassword]
    #         @user["name"] = user_params[:name]
    #         if user_params[:newPassword] != ''
    #           @user["password"] = user_params[:newPassword]
    #           render json: serialize(@user)
    #         end
    #     # curPassword와 user의 비밀번호 일치하지 않는다면 에러 리턴
    #       else
    #         render json: serialize(@user)
    #       end
    # end 
  
    private 
  
    def user_params
        params.require(:user).permit(:name, :email, :curPassword, :newPassword, :newPassword_confirmation, :liked_movies)
    end 
  
    def set_user 
        @user = User.find(params[:id])
    end
end
