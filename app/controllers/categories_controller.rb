class CategoriesController < ApiController
  before_action :set_category, only: [:show, :update, :destroy]
  before_action :set_query_param, only: [:show]

  def index
    if request.path === '/categories'
      categories = Category.all
    else 
      categories = Category.page(params[:page]).per(4)
    end
    
    render json: each_serialize(categories, serializer_name: :CategorySerializer)
  end

  def show
    if @queryParam.blank?
      sortedMovies = @category.movies.page(params[:page]).per(4)
    else 
      if @queryParam[:s] === 'stars desc'
        descSort = @category.movies.order("stars DESC")
        sortedMovies = descSort.page(params[:page]).per(4)
      else 
        ascSort = @category.movies.order("stars ASC")
        sortedMovies = ascSort.page(params[:page]).per(4)
      end
    end
    render json: {
      id: @category.id, 
      title: @category.title,
      movies: sortedMovies, 
    }
  end

  private 

  def set_category
    @category = Category.find(params[:id])
  end

  def set_query_param
    @queryParam = request.query_parameters[:q]
  end

  def permitted_query
    params[:q].permit(:s)
  end
end
