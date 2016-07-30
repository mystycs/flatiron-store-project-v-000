class LineItemsController < ApplicationController
  def create
    line_item = LineItem.find_by(item_id: params[:item_id])

    if !line_item.nil?
      line_item.quantity += 1
      line_item.save
    else

      line_item = LineItem.create(item_id: params[:item_id])
      if current_user.current_cart.nil?
        line_item.cart = Cart.create
        current_user.current_cart = line_item.cart
      else
        line_item.cart = current_user.current_cart
      end
      line_item.save
    end
    current_user.save
    redirect_to cart_path(current_user.current_cart)
  end
end
