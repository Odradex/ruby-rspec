# frozen_string_literal: true

require 'Time'

class TimeIntervals
  def initialize(time_periods)
    @time_periods = time_periods.uniq
  end

  def free_time
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

puts TimeIntervals.new(
  [['10:00', '10:20'],
   ['10:40', '11:00'],
   ['10:50', '12:00'],
   ['12:00', '13:00'],
   ['10:00', '10:20']]
).free_time.inspect
