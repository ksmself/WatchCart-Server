class CategoriesController < ApiController
  def index
    categories = Category.page(params[:page])
    if categories.length == 0
      render json: nil
    else 
      render json: each_serialize(categories, serializer_name: :CategorySerializer)
    end
  end

  def show
    category = Category.find(params[:id])
    render json: serialize(category)
  end
end
