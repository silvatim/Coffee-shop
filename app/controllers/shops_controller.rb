class ShopsController < ApplicationController

def index 
  @shops = Shop.all
end

def new
  @shop = Shop.new
end

def create
  @shop = Shop.create(order_params)
  @shops = Shop.all
  render 'index'
end


private

def order_params
  params.require(:shop).permit(:name, :description)
end

end
