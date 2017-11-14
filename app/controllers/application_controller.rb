class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  around_action :catch_not_found

  def get_cart_items
    @cart_items = []
    logger.warn(cookies)
    cookies.each do |cookie|
      if (cookie[0].include? "item_")
        item_cookie = cookie[0].split("item_")
        logger.warn(item_cookie[1])
         @cart_items << {item: Item.find(item_cookie[1]), qty: cookie[1]}
      end
    end
    return @cart_items
  end

  def verify_item_available
    if !@item.available
      redirect_to forbidden_path
    end
  end

  def verify_admin
    if user_signed_in?
      if !current_user.try(:admin?)
        redirect_to forbidden_path
      end
    end
  end

  def verify_not_admin
    if user_signed_in?
      if current_user.try(:admin?)
        redirect_to welcome_index_path
      end
    end
  end

  def get_cart_total
    @cart_items = get_cart_items
    total = 0.0
    logger.warn(@cart_items)
    @cart_items.each do |cart_item|
      total = (cart_item[:item].price.to_d * cart_item[:qty].to_d) + total
    end
    return total.abs
  end

  def del_cookies
    cookies.each do |cookie|
      if (cookie[0].include? "item_")
        if cookies.delete cookie[0]
          puts "Cookie deleted"
          # cookies[:itemsInCart] = 0
        end
      end
    end
  end

  def create_cookie
    item_id = params[:item][:id]
    qty = params[:qty]
    cookie_id = "item_#{item_id}"
    logger.warn("The cookie will be named: #{cookie_id} and will hold #{qty}")
    if cookies[cookie_id]
      current_qty = cookies[cookie_id]
      logger.warn("Cookie found #{current_qty}")
      cookies[cookie_id] = current_qty.to_i.abs + qty.to_i.abs
    else
      logger.warn("Cookie being created")
      cookies[cookie_id] = qty.to_i.abs
    end
    redirect_to cart_url
  end

  def configure_permitted_parameters
    logger.warn("Permitted parameters:")
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :address, :city, :state_id, :country_id, :zip, :email, :phone, :stripeToken])
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  def humanize(bool)
    if bool
      return "Yes"
    elsif !bool
      return "No"
    end
  end

  private
    def catch_not_found
      yield
      rescue ActiveRecord::RecordNotFound
      redirect_to root_url, alert: 'Stop trying to break me'
    end
end