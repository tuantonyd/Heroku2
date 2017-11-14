class AdminController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
  before_action :verify_admin

  def index
    @uforders = Order.where(order_status: 1).order(:created_at => :desc).paginate(:page => params[:page], :per_page => 15)
    @pforders = Order.where(order_status: 2).order(:created_at => :desc).paginate(:page => params[:page], :per_page => 15)
    @allorders = Order.all.order(:created_at => :desc).paginate(:page => params[:page], :per_page => 15)
  end

  def items
    @items = Item.all
  end

  def reports
    @states_with_orders = State.joins(:orders).order(:state_name).pluck(:state_id, :state_name).uniq #Get states that have an order
    @user_order_report = ReportingHelper.user_total_sales
    logger.warn(@user_order_report)
    @groupedbymonth = ReportingHelper.orders_by_month
  end

  def users
    @users = User.all.order(:first_name)
  end

  def toggle_admin
    @user = User.find(params[:id])
    @user.admin ? @user.update(admin: false) : @user.update(admin: true)
    respond_to do |format|
    format.html { redirect_to user_management_path, notice: "#{@user.full_name}'s admin status has successfully been modified" }
    end
  end
end
