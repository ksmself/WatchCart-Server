class LineitemsController < ApiController
    before_action :set_lineitem, only: [:update]

    def index
        line_items = LineItem.all
        render json: each_serialize(line_items)
    end 

    def create
        params[:line_item].each do |item|
            # puts '내가 바로 item', item
            orderExist = Order.find_by(:user_id => current_api_user.id)
            if orderExist.nil?
                order = Order.create(:user_id => current_api_user.id)
                orderId = order.id
                # puts 'order가 아예 없었음: ', orderId
            else 
                uncompletedExist = Order.find_by(:status => "orderUncompleted", :user_id => current_api_user.id)
                if uncompletedExist.nil?
                    order = Order.create(:user_id => current_api_user.id)
                    orderId = order.id
                    # puts 'uncompleted가 없었음: ', orderId
                else 
                    orderId = uncompletedExist.id
                    # puts 'uncompleted order가 존재했음: ', orderId
                end
            end 

            # 위에서 orderId가 정해졌으니 이미 있는 option인지 확인 필요
            optionExist = LineItem.find_by(:order_id => orderId, option_id: item[:id])
            # puts '옵션 존재 여부', optionExist
            # 처음 장바구니에 담기는 option이라면 line_item 새로 생성 
            if optionExist.nil?
                line_item = LineItem.create(order_id: orderId, option_id: item[:id], quantity: item[:quantity])
                # render json: serialize(line_item)
                # puts '처음 장바구니에 담기는 option'
            # 이미 있는 option_id만 수량만 변경
            else 
                # puts '수량만 변경', optionExist.quantity, item[:quantity]
                optionExist.update(quantity: optionExist.quantity + item[:quantity])
            end
        end
    end

    def show 
        exist = Order.find_by(:status => "orderUncompleted")
        if exist.nil?
            render json: false
        else 
            render json: serialize(exist)
        end
    end

    def update
        @lineitem.update(line_item_params)
        render json: serialize(@lineitem)
    end

    private 

    def line_item_params
        params.require(:line_item).permit(:option_id, :quantity, :order_id)
    end

    def set_lineitem
        @lineitem = LineItem.find(params[:id])
    end

    def permitted_query
        params[:q].permit(:order_id_eq)
    end
end
