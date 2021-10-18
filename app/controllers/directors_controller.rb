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
        if @query_param.blank?
            sortedMovies = @director.movies.select(:id, :title, :stars, :image).page(params[:page]).per(4)
        else
            if @query_param[:s] === 'stars desc'
                descSort = @director.movies.select(:id, :title, :stars, :image).order("stars DESC")
                sortedMovies = descSort.page(params[:page]).per(4)
            else 
                ascSort = @director.movies.select(:id, :title, :stars, :image).order("stars ASC")
                sortedMovies = ascSort.page(params[:page]).per(4)
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
        @query_param = request.query_parameters[:q]
    end
end
