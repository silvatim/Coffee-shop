class OrdersController < ApplicationController
   helper_method :sort_column, :sort_direction
   before_action :set_shop
   before_action :set_order, except: [:index, :show, :update, :edit, :new, :create, :fulfilled_orders, :destroy]

   def index
     @orders = @shop.orders.order(sort_column + " " + sort_direction)
   end

   def new
     @order = @shop.orders.new(size: 'Large')
     @order.user = current_user
   end

   def edit
     @order = @shop.orders.find(params[:id])
   end

   def update
     @order = @shop.orders.find(params[:id])
     if @order.update(order_params)
       render 'create', notice: "Order successfully updated"
     else
       render 'edit'
     end
   end

  def show
    redirect_to root_path, notice: "Order successfully deleted"
  end

  def destroy
    @order= @shop.orders.find(params[:id])
    @order.destroy
    redirect_to shop_orders_fulfilled_path(@shop)
  end

  def create
    @order = @shop.orders.new(order_params)
    @order.user = current_user if user_signed_in?
    @order.save

    UserMailer.order_email(@order).deliver_now
    @amount = 500

    customer = Stripe::Customer.create(
     :email => 'example@stripe.com',
     :card  => params[:stripeToken] )

   charge = Stripe::Charge.create(
     :customer    => customer.id,
     :amount      => @amount,
     :description => 'Rails Stripe customer',
     :currency    => 'usd' )

   rescue Stripe::CardError => e
     flash[:error] = e.message
     redirect_to new_shop_order_path(@shop)
  end

  def fulfilled_orders
  end

  def completed
    @order.complete!
    UserMailer.completed_email(@order).deliver_now
    redirect_to shop_orders_path(@shop)
  end


  def paid
    @order.paid!
    redirect_to shop_orders_path(@shop)
  end

  def estimated
    @order.estimate!(params[:estimate])
    UserMailer.confirmation_email(@order).deliver_now
    redirect_to shop_orders_path(@shop)
  end

  def accept
    @order.accept!
    redirect_to shop_orders_path(@shop)
  end

  def reject
    @order.reject!
    UserMailer.rejection_email(@order).deliver_now
    redirect_to shop_orders_path(@shop)
  end

  def cancel
    @order.cancel!
    redirect_to shop_orders_path(@shop)
  end

  def forgotten
    @order.forgotten!
    redirect_to shop_orders_path(@shop)
  end


 private
  def order_params
    params.require(:order).permit(:first_name, :last_name, :email, :comment, :coffee_type, :milk, :size, :pickup_time)
  end

  def set_shop
    @shop = Shop.find(params[:shop_id])
  end

  def set_order
    @order = @shop.orders.find(params[:order_id])
  end

  def sort_column
    @shop.orders.column_names.include?(params[:sort]) ? params[:sort] : "last_name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def order_params
    params.require(:order).permit(:first_name, :last_name, :email, :comment, :coffee_type, :milk, :size, :pickup_time)
  end

end

