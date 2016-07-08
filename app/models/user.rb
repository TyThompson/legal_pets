class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :pets, foreign_key: "seller_id"
  has_many :purchases, class_name: "Pet", foreign_key: "buyer_id"
  has_many :watchlists
  has_many :charges, foreign_key: "buyer_id"
  has_many :charges, foreign_key: "seller_id"

  def admin?
    self.admin
  end
end
