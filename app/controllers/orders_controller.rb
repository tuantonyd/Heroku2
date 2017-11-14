class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new]
  before_action :verify_not_admin, only: [:new, :index]
  layout :check_admin, only: [:show, :edit]


  def check_admin
    if user_signed_in?
      if current_user.try(:admin?)
        return 'admin'
      end
    end
  end

  # GET /orders
  # GET /orders.json
  Stripe.api_key = "sk_test_XraleY3YiXwA1SaECNkivejC"

  def index
    @orders = Order.where(user: current_user)
  end

  # GET /orders/1
  # GET /orders/1.json
  def show

  end

  # GET /orders/new
  def new
    @order = Order.new
    @total = get_cart_total
    @user = current_user
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    token = params[:stripeToken]
    total = (get_cart_total*100).round
    charge = Stripe::Charge.create(
      :amount => total,
      :currency => "usd",
      :description => "Example charge",
      :source => token,
    )
    logger.warn(charge.outcome.network_status.include? "approved")
    logger.warn("stripe token::::: " + token)
    logger.warn(charge.id)
    if charge.outcome.network_status.include? "approved"
      @cart_items = get_cart_items
      @user = current_user
      @order = Order.create(user: @user, total: get_cart_total, stripe_key: charge.id, zip: params[:order][:zip], state_id: params[:order][:state_id], country_id: params[:order][:country_id], address: params[:order][:address], city: params[:order][:city], notes: params[:order][:notes], first_name: params[:order][:first_name], last_name: params[:order][:last_name], address_two: params[:order][:address_two])
      @cart_items.each do |cart_item|
        @order_lines = OrderLine.create(order_id: @order.id, item_id: cart_item[:item].id, qty: cart_item[:qty], order_line_status_id: 1)
      end
    end

    respond_to do |format|
      if @order.save && @order_lines.save
        puts "Success"
        del_cookies
        format.html { redirect_to @order, notice: 'Order was succesfully created.' }
        #format.json { render :show, status: :ok, location: @order}
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    params[:order_lines].each do |order_c_params|
      order_status = params[:order_lines][order_c_params][:order_line_status]
      fulfilled = params[:order_lines][order_c_params][:quantity_fulfilled]
      logger.warn("New order status id: #{order_status}")
      OrderLine.find(order_c_params).update(order_line_status_id: order_status, quantity_fulfilled: fulfilled)
    end

    respond_to do |format|
      format.html { redirect_to order_path, notice: 'Order was successfully updated.' }
      format.json { render :show, status: :ok, location: @order }
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
      @user = current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:first_name, :last_name, :total, :notes, :state_id, :address,:city, :zip, :order_lines[])
    end

    def item
      logger.warn("Item ID: ")
      logger.warn (params[:item])
      params.permit(:item)
    end
end
