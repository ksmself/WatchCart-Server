class ActorsController < ApiController
    before_action :set_actor, only: [:show]
    before_action :set_query_param, only: [:show]

    def index 
        actors = Actor.includes(:played_movies).all
        render json: each_serialize(actors)
    end

    def create
        actor = Actor.create(actor_params)
        render json: serialize(actor)
    end 

    def show
        if @query_param.blank?
            sortedMovies = @actor.played_movies.select(:id, :title, :stars, :image).page(params[:page]).per(4)
        else
            if @query_param[:s] === 'stars desc'
                descSort = @actor.played_movies.select(:id, :title, :stars, :image).order("stars DESC")
                sortedMovies = descSort.page(params[:page]).per(4)
            else 
                ascSort = @actor.played_movies.select(:id, :title, :stars, :image).order("stars ASC")
                sortedMovies = ascSort.page(params[:page]).per(4)
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
        @query_param = request.query_parameters[:q]
    end

    def permitted_query
        params[:q].permit(:id_eq)
    end
end
