class UsersController < ApplicationController

  before_action :set_user
  before_action :set_order, except: [:index]

  def index
    @orders = @user.orders
  end

  def edit
  end

  def update
    if @order.update(order_params)
      redirect_to user_orders_path(@user), notice: "Order successfully updated"
    else
      render 'edit'
    end
  end

  def destroy
    @order.destroy
    redirect_to user_orders_path(@user)
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

