class GoodsController < ApiController
    def good_toggle
        good = Good.find_by(user_id: current_api_user.id, movie_id: params[:id])

        if good.blank?
            Good.create(user_id: current_api_user.id, movie_id: params[:id])
            render json: true 
        else 
            good.destroy
            render json: false
        end
    end 

    def is_good
        good = Good.find_by(user_id: current_api_user.id, movie_id: params[:id])

        if good.blank?
            render json: false
        else 
            render json: true
        end
    end
end
