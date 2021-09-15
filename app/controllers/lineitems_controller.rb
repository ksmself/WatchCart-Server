class LineitemsController < ApiController
    def index
        line_items = LineItem.all
        render json: each_serialize(line_items)
    end 

    def create 
        # current user의 order 중에서 uncompleted 상태의 order가 있는지 먼저 확인
        exist = Order.find_by(:status => "orderUncompleted", :user_id => current_api_user.id)
        if exist.nil?
            order = Order.create(:user_id => current_api_user.id)
            orderId = order.id
        else 
            orderId = exist.id
        end

        # line_item_params를 통해 option_id, quantity 받아옴
        line_item = LineItem.create(order_id: orderId, option_id: line_item_params[:option_id], quantity: line_item_params[:quantity])
        render json: serialize(line_item)
    end 

    def show 
        exist = Order.find_by(:status => "orderUncompleted")
        if exist.nil?
            render json: false
        else 
            render json: serialize(exist)
        end
    end

    private 

    def line_item_params
        params.require(:line_item).permit(:option_id, :quantity, :order_id)
    end

    def permitted_query
        params[:q].permit(:order_id_eq)
    end
end
