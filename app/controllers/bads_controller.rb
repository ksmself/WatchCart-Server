class BadsController < ApiController
    def bad_toggle
        bad = Bad.find_by(user_id: current_api_user.id, movie_id: params[:id])

        if bad.blank?
            Bad.create(user_id: current_api_user.id, movie_id: params[:id])
            render json: true 
        else 
            bad.destroy
            render json: false
        end
    end 

    def is_bad
        bad = Bad.find_by(user_id: current_api_user.id, movie_id: params[:id])

        if bad.blank?
            render json: false
        else 
            render json: true
        end
    end
end
