class ActorsController < ApiController
    before_action :set_actor, only: [:show]

    def index 
        #actors = Actor.ransack(params[:q]).result
        actors = Actor.includes(:played_movies).all
        render json: each_serialize(actors)
    end

    def create
        actor = Actor.create(actor_params)
        render json: serialize(actor)
    end 

    def show
        render json: serialize(@actor)
    end

    private 

    def actor_params
        params.require(:actor).permit(:name, :played_movies)
    end

    def set_actor 
        @actor = Actor.find(params[:id])
    end

    def permitted_query
        params[:q].permit(:id_eq)
    end
end
