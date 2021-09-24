class CategoriesController < ApiController
  def index
    if request.path === '/categories'
      categories = Category.all
    else 
      categories = Category.page(params[:page])
    end
    
    render json: each_serialize(categories, serializer_name: :CategorySerializer)
  end

  def show
    category = Category.find(params[:id])
    render json: serialize(category)
  end
end
