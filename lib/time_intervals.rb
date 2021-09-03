require 'time'

class TimeIntervals
  def initialize(time_periods)
    @time_periods = time_periods.uniq unless time_periods.nil?
  end

  def unite_periods
    @time_periods.sort_by { |period| Time.parse(period.first) }.each do |period|
      next_period = @time_periods[@time_periods.find_index(period) + 1]
      break if next_period.nil?

      if overlap?(period, next_period)
        next_period[0] = period[0]
        @time_periods.delete(period)
      end
    end
    @time_periods
  end

  def overlap?(first_period, second_period)
    Time.parse(first_period.last) >= Time.parse(second_period.first)
  end
end
