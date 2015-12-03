class Shop < ActiveRecord::Base

has_many :orders, dependent: :destroy
has_many :users, :through => :orders


STATE = ['ACT','NSW','QLD','VIC','TAS','WA','NT','SA']
validates :street_num, presence: true
validates :street, presence: true
validates :suburb, presence: true
validates :state, inclusion: { in: STATE }
validates :postcode, presence: true


end
