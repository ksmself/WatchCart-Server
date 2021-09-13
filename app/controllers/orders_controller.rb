class OrdersController < ApiController
    def index 
		# orders = current_api_user.orders
		orders = Order.all
		render json: each_serialize(orders)
	end

	def create
		order = Order.create(order_params)
		render json: serialize(order)
	end 

	private 

	def order_params
		params.require(:order).permit(:user_id, :receiver_name, :receiver_phone, :address1, :total, :status)
	end 

	def permitted_query
        params[:q].permit(:status_eq)
    end
end
