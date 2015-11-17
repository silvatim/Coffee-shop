class OrdersController < ApplicationController

before_action :set_shop


def index
  @orders = @shop.orders
end

def new
  @order = @shop.orders.new
  @order.user = current_user 
end

def create 
  @order = @shop.orders.new(order_params)
  @order.user = current_user if user_signed_in?
  @order.save

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

def fulfilled_orders
end

def completed
  @order.complete!
  UserMailer.completed_email(@order).deliver_now
  render 'index'
end


def paid
  @order.paid!
  render 'index'
end

def estimated
  @order.estimate!(params[:estimate])
  UserMailer.confirmation_email(@order).deliver_now
  render 'index'
end

def reject
  @order.reject!
  UserMailer.rejection_email(@order).deliver_now
  render 'index'
end

def cancel
  @order.cancel!
  render 'index'
end

def forgotten
  @order.forget!
  render 'index'
end

private

  def order_params
    params.require(:order).permit(:first_name, :last_name, :email, :comment, :coffee_type, :milk, :size, :pickup_time)
  end

  def set_shop
    @shop = Shop.find(params[:shop_id])
  end

  
end

