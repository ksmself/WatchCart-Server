class LineitemsController < ApiController
    before_action :set_lineitem, only: [:show, :update, :destroy]

    def index
        line_items = LineItem.all.ransack(params[:q]).result
        render json: each_serialize(line_items)
    end 

    def create
        params[:line_item].each do |item|
            orderExist = Order.find_by(:user_id => current_api_user.id)
            if orderExist.blank?
                order = Order.create(:user_id => current_api_user.id)
                orderId = order.id
            else 
                uncompletedExist = Order.find_by(:status => "orderUncompleted", :user_id => current_api_user.id)
                if uncompletedExist.blank?
                    order = Order.create(:user_id => current_api_user.id)
                    orderId = order.id
                else 
                    orderId = uncompletedExist.id
                end
            end 

            # 위에서 orderId가 정해졌으니 이미 있는 option인지 확인 필요
            optionExist = LineItem.find_by(:order_id => orderId, option_id: item[:id])
            # 처음 장바구니에 담기는 option이라면 line_item 새로 생성 
            if optionExist.blank?
                line_item = LineItem.create(order_id: orderId, option_id: item[:id], quantity: item[:quantity])
            # 이미 있는 option_id만 수량만 변경
            else 
                optionExist.update(quantity: optionExist.quantity + item[:quantity])
            end
        end
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
