class OrdersController < ApiController
	before_action :set_order, only: [:show, :update, :destroy]

    def index 
		# orders = current_api_user.orders
		orders = Order.all.ransack(params[:q]).result
		render json: each_serialize(orders)
	end

	def create
		order = Order.create(order_params)
		render json: serialize(order)
	end 

	def show
		order = Order.includes(:line_items).find(params[:id])
		render json: serialize(order)
	end

	def update 
		@order.update(order_params)
		render json: serialize(@order)
	end

	private 

	def order_params
		params.require(:order).permit(:user_id, :receiver_name, :receiver_phone, :address1, :total, :status, :line_items)
	end 

	def set_order
		@order = Order.find(params[:id])
	end

	def permitted_query
        params[:q].permit(:status_eq, :user_id_eq)
    end
end
