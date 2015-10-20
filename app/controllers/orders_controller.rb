class OrdersController < ApplicationController


def new
  @shop = Shop.find(params[:shop_id])
  @order = Order.new
end

def create 
  @shop = Shop.find(params[:shop_id])
  @order = @shop.orders.create(order_params)
end

def index
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
  render 'index'
end


private

def order_params
  params.require(:order).permit(:name, :email, :order)
end

end


