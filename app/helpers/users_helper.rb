module UsersHelper

  def order_new(order)
    order.state == "new"
  end

end
