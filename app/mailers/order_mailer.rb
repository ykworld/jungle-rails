class OrderMailer < ApplicationMailer  
  def order_receipt_email(order_id)
    @order = Order.find_by(id: order_id);
    mail(to: @order.email, subject: 'Your order receipt!')
  end
end
