module OrdersHelper

  def start_time(start_hour)
    if start_hour > 7 && start_hour < 18
       start_hour = Time.now
    else
       start_hour = 0
    end
  end
end
