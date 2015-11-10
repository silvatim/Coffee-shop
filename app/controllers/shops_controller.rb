class ShopsController < ApplicationController


def index 
  @shops = Shop.all
end

def new
  @shop = Shop.new
end

def create
  @shop = Shop.create(shop_params)
  @shops = Shop.all
  if @shop.save
    render 'index', notice: "Shop successfully created"
  else
    render 'new'
  end
end

def edit
  @shop = Shop.find(params[:id])
end

def update
  @shop = Shop.find(params[:id])
  @shops = Shop.all
  if @shop.update(shop_params)
  	render 'index', notice: "Shop successfully updated"
  else
  	render :edit
  end
end

def destroy
  @shop = Shop.find(params[:id])
  @shops = Shop.all
  @shop.destroy
  render 'index', notice: "Shop successfully deleted"
end


private

def shop_params
  params.require(:shop).permit(:street_num, :street, :suburb, :state, :postcode)
end

end
