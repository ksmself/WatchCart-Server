class DirectorsController < ApiController
    before_action :set_director, only: [:show, :update, :destroy]

    def index
        directors = Director.all
        render json: each_serialize(directors)
    end

    def create
        director = Director.create(director_params)
        render json: serialize(director)
    end 

    def show
        render json: serialize(@director)
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
end
