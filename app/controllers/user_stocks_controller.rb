class UserStocksController < ApplicationController
  def create
    if UserStock.find_by(user_id: params[:user], stock_id: params[:stock])
      flash.now[:alert] = "Stock already exist."
    else
      @user_stock = UserStock.create(user_id: params[:user], stock_id: params[:stock])
      redirect_to my_portfolio_path
    end
  end

  def destroy
    @user_stock = UserStock.find_by(user_id: current_user.id, stock_id: params[:id])
    @user_stock.destroy()
    redirect_to my_portfolio_path
  end
end
