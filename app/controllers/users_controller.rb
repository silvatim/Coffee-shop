class UsersController < ApplicationController

before_action :set_user
before_action :set_order, except: [:index]

  def index
    @orders = @user.orders
  end

  def edit_order
  end

  def update_order
    if @order.update(order_params)
  	  render 'index', notice: "Order successfully updated"
    else
  	  render :edit
    end
  end


  def cancel_order
    @order.destroy
    render 'index'
  end

private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_order
    @order = @user.orders.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:first_name, :last_name, :email, :comment, :coffee_type, :milk, :size, :pickup_time)
  end

end

