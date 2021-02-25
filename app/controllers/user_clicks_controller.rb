class UserClicksController < ApplicationController
  def create
    @user_click = UserClick.new(user_click_params)
    render json: @user_click, status: :ok and return if @user_click.save
    
    render json: @user_click.errors.messages, status: :bad_request and return unless @user_click.valid?
  end

  private

  def user_click_params
    params.require(:user_click).permit(:path_name, :clicks_amount)
  end
end
