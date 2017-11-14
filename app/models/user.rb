class User < ApplicationRecord
  has_many :orders
  validates_presence_of :email, :first_name, :last_name, :address, :city, :country_id, :state_id, :zip
  #validate :email_validator
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

 def full_name
   return "#{first_name} #{last_name}"
 end

 def email_validator
   logger.warn("Validating this shit")
   if User.where(email: email)
     logger.warn("LOL")
     errors.add(:email, "SHIT")
   end
 end

 def total_spent
   return Order.join(:user).sum(:total).group(:user_id).where(user: id)
 end
 def humanize(bool)
   if bool
     return "Yes"
   else
     return "No"
   end
 end


end
