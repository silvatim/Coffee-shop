class OrdersController < ApplicationController


def new
  @order = Order.new
end

def create 
  @order = Order.create(order_params)
end

def index

end

def completed
  @order = Order.find(params[:order_id])
  @order.complete!
  render 'index'
end


def paid
  @order = Order.find(params[:order_id])
  @order.paid!
  render 'index'
end

def estimated
  @order = Order.find(params[:order_id])
  @order.estimate!(params[:estimate])

  render 'index'
end



private

def order_params
  params.require(:order).permit(:name, :email, :order)
end

end


