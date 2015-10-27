class Order < ActiveRecord::Base
    
    
	belongs_to :shop
	validates :name, :order, presence: true
	validates :email, presence: true, format: /\A\S+@\S+\z/

	scope :completed, -> { where(state: 'completed') }
	scope :discarded, -> { where(state: ['rejected','cancelled','forgotten']) }
	scope :working, -> { where(state: 'working') }
	scope :new_orders, -> { where(state: 'new') }
	scope :paid, -> { where(state: 'paid') }

	def estimate!(estimate)
	  update_attributes({estimate_taken: Time.now, estimate_given: estimate, state: 'working'})
	end
	
	def paid!
	  update_attributes({finished_at: Time.now, state: 'paid'})
	end

	def complete!
	  update_attributes({completed_at: Time.now, state: 'completed'})
	end

	def reject!
		update_attributes({completed_at: Time.now, state: 'rejected'})
	end

	def cancel!
		update_attributes({completed_at: Time.now, state: 'cancelled'})
	end

	def forget!
		update_attributes({completed_at: Time.now, state: 'forgotten'})
	end

	def estimate_time
	  estimate_taken + estimate_given.minutes
	end

end
