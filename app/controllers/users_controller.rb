class UsersController < ApiController
    before_action :set_user, only: [:show, :update, :show_liked_movies, :show_order_list, :show_rated_good, :show_rated_bad]
    before_action :set_order_list, only: [:show_order_list]
    before_action :set_liked_movies, only: [:show_liked_movies]
    before_action :set_rated_good, only: [:show_rated_good]
    before_action :set_rated_bad, only: [:show_rated_bad]

    def show
        render json: serialize(@user)
    end

    def update
        if @user.update_with_password(user_params)
            render json: true 
        else
            render json: {error: "현재 비밀번호를 다시 확인해주세요" }
        end 
    end

    def show_order_list
        orders = Kaminari.paginate_array(@order_list).page(params[:page]).per(3)
        render json: {
            orders: orders, 
        }
    end

    def show_liked_movies
        movies = @liked_movies.page(params[:page]).per(6)
        render json: {
            liked_movies: movies,
        }
    end

    def show_rated_good
        rated_good = @rated_good.page(params[:page]).per(6)
        render json: {
            rated_good: rated_good, 
        }
    end

    def show_rated_bad
        rated_bad = @rated_bad.page(params[:page]).per(6)
        render json: {
            rated_bad: rated_bad, 
        }
    end
  
    private 
  
    def user_params
        params.require(:user).permit(:name, :email, :current_password, :password, :password_confirmation, :liked_movies, :orders)
    end 
  
    def set_user 
        @user = User.includes(:orders).find(params[:id])
    end

    def set_order_list
        @orders = serialize(@user)['orders']
        @order_completed = []
        @orders.each do |order|
            if(order['status'] == 'orderCompleted') 
                @order_completed << order
            end
        end
        @order_list = @order_completed
    end

    def set_liked_movies
        @liked_movies = @user.liked_movies
    end

    def set_rated_good
        @rated_good = @user.rated_good
    end

    def set_rated_bad
        @rated_bad = @user.rated_bad
    end

    def permitted_query
        params[:q].permit(:status_eq)
    end
end
