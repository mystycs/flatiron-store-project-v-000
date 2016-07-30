class CartsController < ApplicationController
  def show
    @cart = Cart.find(params[:id])
  end

  def checkout
    @cart = current_user.current_cart
    @cart.checkout
    current_user.current_cart = nil
    current_user.save

    redirect_to cart_path(current_user)
  end
end
