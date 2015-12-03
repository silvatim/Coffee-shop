class ShopsController < ApplicationController

before_action :set_shop, only: [:edit, :update, :destroy]
before_action :set_all_shops, except: [:new, :show, :index, :edit]


def index 
  
end

def show
  @shops = Shop.all
  if params[:state]
    @shops = Shop.find_by(params[:state])
  else
    @shops = Shop.all
  end  
end

def new
  @shop = Shop.new
end

def create
  @shop = Shop.create(shop_params)
  if @shop.save
    redirect_to shops_path, notice: "Shop successfully created"
  else
    render 'new'
  end
end

def edit
end

def update
  if @shop.update(shop_params)
  	redirect_to shops_path, notice: "Shop successfully updated"
  else
  	render 'edit'
  end
end

def destroy
  @shop.destroy
  redirect_to shops_path, notice: "Shop successfully deleted"
end


private

  def shop_params
    params.require(:shop).permit(:street_num, :street, :suburb, :state, :postcode)
  end

  def set_shop
    @shop = Shop.find(params[:id])
  end

  def set_all_shops
    @shops = Shop.all
  end

end
