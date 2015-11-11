class UserMailer < ApplicationMailer

   default from: ENV['SENDGRID_USERNAME']
 
  def order_email(order)
    @order = order
    @url  = 'http://coffeeapp.com/login'
    mail(to: @order.email, subject: 'Your Coffee Order')
  end

  def confirmation_email(order)
    @order = order
    @url  = 'http://coffeeapp.com/login'
    mail(to: @order.email, subject: 'Order Confirmation')
  end

  def rejection_email(order)
    @order = order
    @url  = 'http://coffeeapp.com/login'
    mail(to: @order.email, subject: 'Order Rejection')
  end

end
