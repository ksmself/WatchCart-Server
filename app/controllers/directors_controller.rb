class DirectorsController < ApiController
    before_action :set_director, only: [:show, :update, :destroy]
    before_action :set_query_param, only: [:show]

    def index
        directors = Director.all
        render json: each_serialize(directors)
    end

    def create
        director = Director.create(director_params)
        render json: serialize(director)
    end 

    def show
        if @queryParam.blank?
            sortedMovies = @director.movies
        else
            if @queryParam[:s] === 'stars desc'
                sortedMovies = @director.movies.sort{ |a, b| b.stars <=> a.stars } 
            else 
                sortedMovies = @director.movies.sort{ |a, b| a.stars <=> b.stars } 
            end
        end
        render json: {
            id: @director.id, 
            name: @director.name,
            movies: sortedMovies, 
        }
    end

    def update
        @director.update(director_params)
        render json: serialize(@director)
    end

    def destroy
        @director.destroy
        render json: serialize(@director)
    end

    private

    def director_params
        params.require(:director).permit(:name)
    end

    def set_director
        @director = Director.find(params[:id])
    end

    def set_query_param
        @queryParam = request.query_parameters[:q]
    end
end
