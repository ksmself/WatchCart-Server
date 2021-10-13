class MoviesController < ApiController
    before_action :set_movie, only: [:show, :update, :destroy]

    def index
        movies = Movie.all
        render json: each_serialize(movies)
    end

    def create
        movie = Movie.create(movie_params)
        render json: serialize(movie)
    end

    def show
        render json: serialize(@movie)
    end

    def update
        @movie.update(movie_params)
        render json: serialize(@movie)
    end
        
    def destroy
        @movie.destroy
        render json: serialize(@movie)
    end

    def search
        total = []
        movies = Movie.ransack(title_cont: params[:q]).result
        actors = Movie.ransack(played_actors_name_cont: params[:q]).result
        directors = Movie.ransack(director_name_cont: params[:q]).result
        movies.each do |movie|
            total << movie
        end
        actors.each do |actor|
            total << actor
        end
        directors.each do |director|
            total << director
        end
        render json: total
    end

    private

    def movie_params
        params.require(:movie).permit(:category_id, :director_id, :title, :year, :stars, :image, :description, :played_actors)
    end

    def set_movie
        @movie = Movie.find(params[:id])
    end

    # 아무거나 query를 던질 수 없게 permitted 설정
    # 현재는 title 검색과 sorting 정도만
    def permitted_query
        params[:q].permit(:title_cont, :category_id_eq, :id_eq, :s, :played_actors_name_cont, :director_name_cont)
    end
end
