class LineitemsController < ApiController
    before_action :set_lineitem, only: [:show, :update, :destroy]

    def index
        line_items = LineItem.ransack(params[:q]).result
        render json: each_serialize(line_items)
    end 

    def create
        params[:line_item].each do |item|
            order = current_api_user.orders.find_or_create_by(status: 'orderUncompleted')
            order_option = order.line_items.find_by_option_id(item[:id])
            if order_option
                order_option.update(quantity: order_option.quantity + item[:quantity])
            else
                order.line_items.create(option_id: item[:id], quantity: item[:quantity])
            end
        end
    end

    def create_quick_line_item
        quick_line_items = []
        params[:line_item].each do |item|
            order = current_api_user.orders.find_or_create_by(status: 'orderUncompleted')
            quick_line_item = order.line_items.create(option_id: item[:id], quantity: item[:quantity])
            quick_line_item = LineItem.includes(:option).find_by(id: quick_line_item.id)
            quick_line_items.push(serialize(quick_line_item))
        end
        render json: quick_line_items
    end

    def show
        lineitem = LineItem.includes(:option).find(params[:id])
        render json: serialize(lineitem)
    end

    def update
        @lineitem.update(line_item_params)
        render json: serialize(@lineitem)
    end

    def destroy
        @lineitem.destroy
        render json: serialize(@lineitem)
    end

    private 

    # 이상한 pararmeter가 날라올 수도 있으니 permit하는 것
    def line_item_params
        params.require(:line_item).permit(:option_id, :quantity, :order_id, :status, :id, :option, :order)
    end

    def set_lineitem
        @lineitem = LineItem.find(params[:id])
    end

    def permitted_query
        params[:q].permit(:order_id_eq, :status_eq)
    end
end
