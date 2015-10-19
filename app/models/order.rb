class Order < ActiveRecord::Base

	def estimate!(estimate)
	  update_attributes({estimate_taken: Time.now, estimate_given: estimate, state: 'working'})
	end
	
	def paid!
	  update_attributes({finshed_at: Time.now, state: 'paid'})
	end

	def complete!
	  update_attributes({completed_at: Time.now, state: 'completed'})
	end

	def self.working_orders
      Order.where(state:'working')
	  
    end
	
	def self.completed_orders
	  Order.where(state:'completed')
	end
	
	def self.new_orders
	  Order.where(state:'new')
	end

	def self.finished_orders
      Order.where(state: ['paid'])

	end

	def estimate_time
	  estimate_taken + estimate_given.minutes
	end



end
