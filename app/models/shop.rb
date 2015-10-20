class Shop < ActiveRecord::Base

has_many :orders, dependent: :destroy

validates :name, presence: true
validates :description, length: {maximum: 20}


end
