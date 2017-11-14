class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update_account]

  def edit
    @orders = Order.where(user: current_user).order(:created_at => :desc)
  end

  def set_user
    @user = current_user
  end

  def update_account
    if @user.update(user_params)
    respond_to do |format|
      format.html { redirect_to edit_account_url, notice: 'Account Updated'}
    end
    else
      respond_to do |format|
        format.html { redirect_to edit_account_url, alert: @user.errors.full_messages}
      end
    end
  end

  private
  def user_params
      params.require(:user).permit(:first_name, :last_name, :address, :address_two,:city, :zip, :state_id, :country_id, :email, :phone)
  end

  
end
