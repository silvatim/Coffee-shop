class Order < ActiveRecord::Base
    
	belongs_to :shop
	belongs_to :user

	COFFEE_TYPE = ['Expresso', 'Cappuccino', 'Flat White', 'Latte Mocha', 'Macchiato']
	MILK = ['Regular milk','Low fat milk','Soy milk','Almond milk']
    SIZE = ['Large','Medium','Small']


	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :email, presence: true, format: /\A\S+@\S+\z/
    validates :coffee_type, inclusion: { in: COFFEE_TYPE } 
    validates :milk, inclusion: { in: MILK }
    validates :size, inclusion: { in: SIZE } 

	scope :completed, -> { where(state: 'completed') }
	scope :discarded, -> { where(state: ['rejected','cancelled','forgotten']) }
	scope :working, -> { where(state: 'working') }
	scope :new_orders, -> { where(state: 'new') }
	scope :paid, -> { where(state: 'paid') }

	def estimate!(estimate)	
	  update_attributes({pickup_time: estimate, state: 'working'}) #estimate_taken: Time.now, estimate_given: estimate,
	end

	def paid!
	  update_attributes({finished_at: Time.now, state: 'paid'})
	end

	def complete!
	  update_attributes({completed_at: Time.now, state: 'completed'})
	end

	def accept!
      update_attributes({state: 'working'})
	end

	def reject!
	  update_attributes({completed_at: Time.now, state: 'rejected'})
	end

	def cancel!
	  update_attributes({completed_at: Time.now, state: 'cancelled'})
	end

    def forgotten!
	  update_attributes({completed_at: Time.now, state: 'forgotten'})
	end

	def modified_pickup_time
	  pickup_time + estimate_given.minutes
	end

end
