class PlaysController < ApiController
    before_action :set_play, only: [:show]

    def index
        plays = Play.ransack(params[:q]).result
        render json: each_serialize(plays)
    end

    def show
        render json: serialize(@play)
    end
    
    private 

    def play_params
        params.require(:play).permit(:actor_id, :movie_id)
    end 

    def set_play
        @play = Play.find(params[:id])
    end

    def permitted_query
        parmas[:q].permit(:actor_id_eq, :movie_id_eq)
    end
end
