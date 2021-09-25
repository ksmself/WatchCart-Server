class ActorsController < ApiController
    before_action :set_actor, only: [:show]
    before_action :set_query_param, only: [:show]

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
        if @queryParam.nil?
            sortedMovies = @actor.played_movies
        else
            if @queryParam[:s] === 'stars desc'
                sortedMovies = @actor.played_movies.sort{ |a, b| b.stars <=> a.stars } 
            else
                sortedMovies = @actor.played_movies.sort{ |a, b| a.stars <=> b.stars } 
            end
        end
        render json: {
            id: @actor.id, 
            name: @actor.name, 
            movies: sortedMovies,
        }
    end

    private 

    def actor_params
        params.require(:actor).permit(:name, :played_movies)
    end

    def set_actor 
        @actor = Actor.find(params[:id])
    end

    def set_query_param
        @queryParam = request.query_parameters[:q]
    end

    def permitted_query
        params[:q].permit(:id_eq)
    end
end
