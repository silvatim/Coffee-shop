class User < ActiveRecord::Base
  has_many :orders, dependent: :destroy
  has_many :shops, :through => :orders

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, format: /\A\S+@\S+\z/



  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


end
