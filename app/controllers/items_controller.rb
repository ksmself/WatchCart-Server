class ItemsController < ApiController
  def index
    items = Item.ransack(index_params).result
    render json: {
      items: each_serialize(items),
      total_count: items.count
    }
  end

  def show
    item = Item.find(params[:id])
    render json: serialize(item)
  end

  private

  def index_params
    params.fetch(:q, {}).permit(:s, :category_id_eq)
  end
end
