class RatingsController < ApiController
    def good_toggle
        good = Rating.find_by(user_id: current_api_user.id, movie_id: params[:id], status: 0)

        if good.blank?
            Rating.create(user_id: current_api_user.id, movie_id: params[:id], status: 0)
            render json: true
        else
            good.destroy
            render json: false
        end
    end

    def bad_toggle
        bad = Rating.find_by(user_id: current_api_user.id, movie_id: params[:id], status: 1)

        if bad.blank?
            Rating.create(user_id: current_api_user.id, movie_id: params[:id], status: 1)
            render json: true
        else
            bad.destroy
            render json: false
        end
    end

    def is_good
        good = Rating.find_by(user_id: current_api_user.id, movie_id: params[:id], status: 0)

        if good.blank?
            render json: false
        else
            render json: true
        end
    end

    def is_bad
        bad = Rating.find_by(user_id: current_api_user.id, movie_id: params[:id], status: 1)

        if bad.blank?
            render json: false
        else
            render json: true
        end
    end
end
