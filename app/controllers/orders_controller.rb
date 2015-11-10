class OrdersController < ApplicationController

def new
  @shop = Shop.find(params[:shop_id])
  @order = Order.new
end

def create 
  @shop = Shop.find(params[:shop_id])
  @order = @shop.orders.create(order_params)
  UserMailer.order_email(@order).deliver_now

  @amount = 500

  customer = Stripe::Customer.create(
    :email => 'example@stripe.com',
    :card  => params[:stripeToken]
  )

  charge = Stripe::Charge.create(
    :customer    => customer.id,
    :amount      => @amount,
    :description => 'Rails Stripe customer',
    :currency    => 'usd'
  )

rescue Stripe::CardError => e
  flash[:error] = e.message
  redirect_to new_shop_order_path(@shop)
end


def index
  @shop = Shop.find(params[:shop_id])
end

def fulfilled_orders
  @shop = Shop.find(params[:shop_id])
end

def completed
  @order = Order.find(params[:order_id])
  @order.complete!
  @shop = Shop.find(params[:shop_id])
  render 'index'
end


def paid
  @order = Order.find(params[:order_id])
  @order.paid!
  @shop = Shop.find(params[:shop_id])
  render 'index'
end

def estimated
  @order = Order.find(params[:order_id])
  @order.estimate!(params[:estimate])
  @shop = Shop.find(params[:shop_id])
  UserMailer.confirmation_email(@order).deliver_now
  render 'index'
end

def reject
  @order = Order.find(params[:order_id])
  @order.reject!
  @shop = Shop.find(params[:shop_id])
  UserMailer.rejection_email(@order).deliver_now
  render 'index'
end

def cancel
  @order = Order.find(params[:order_id])
  @order.cancel!
  @shop = Shop.find(params[:shop_id])
  render 'index'
end

def forgotten
  @order = Order.find(params[:order_id])
  @order.forget!
  @shop = Shop.find(params[:shop_id])
  render 'index'
end

private

def order_params
  params.require(:order).permit(:name, :email, :comment, :coffee_type, :milk, :size, :pickup_time)
end

end


