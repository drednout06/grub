# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(255)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer         default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#  first_name             :string(255)
#  last_name              :string(255)
#  phone_number           :string(255)
#  admin                  :boolean         default(FALSE), not null
#  restaurateur           :boolean         default(FALSE)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
  	:first_name, :last_name, :phone_number, :admin, :restaurateur
  
  has_many :addresses, dependent: :destroy
  has_many :orders
  has_many :reviews, dependent: :destroy
  has_many :evaluations, class_name: "RSEvaluation", as: :source
  has_many :restaurants, dependent: :destroy
  has_many :transactions, through: :restaurants, source: :orders
  has_many :user_favorites, dependent: :destroy
  has_many :favorites, through: :user_favorites, source: :restaurant

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, presence: true

  def admin?
    self.admin == true
  end

  def name
    "#{first_name} #{last_name}"
  end

  def rating_for(restaurant)
    evaluations.where(target_type: restaurant.class, target_id: restaurant.id).first.try(:value) || 0
  end

  def favorite(restaurant)
    user_favorites.where(restaurant_id: restaurant.id).first
  end

  def favorited?(restaurant)
    user_favorites.where(restaurant_id: restaurant.id).exists?
  end
  
  def restaurant_orders_count(restaurant_id)
    orders.where(restaurant_id: restaurant_id).count
  end
end
