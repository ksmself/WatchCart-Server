class LikesController < ApiController
    def like_toggle 
        #puts params[:like][:user_id]
        # params[:user]
        like = Like.find_by(user_id: current_api_user.id, movie_id: params[:id])

        if like.blank?
            Like.create(user_id: current_api_user.id, movie_id: params[:id])
            render json: true 
        else 
            like.destroy
            render json: false
        end

        # redirect_to :back
    end 

    # 해당 post에 좋아요를 눌렀는지 확인
    def is_like
        like = Like.find_by(user_id: current_api_user.id, movie_id: params[:id])

        if like.blank?
            render json: false
        else 
            render json: true
        end
    end
end
