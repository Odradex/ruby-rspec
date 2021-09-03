require 'time'

class TimeIntervals
  def initialize(time_periods)
    raise ArgumentError unless time_periods.all? { |period| period.size == 2 && period.all? { |time| Time.parse(time)} }

    @time_periods = time_periods.uniq unless time_periods.nil?
  end

  def unite_periods
    @time_periods.sort_by! { |period| Time.parse(period.first) }.each do |period|
      loop do
        next_period = @time_periods[@time_periods.index(period) + 1]
        break if next_period.nil?
        break unless overlap?(period, next_period)

        period[1] = next_period.last
        @time_periods.delete(next_period)
      end
    end
  end

  def overlap?(first_period, second_period)
    (Time.parse(first_period.last) >= Time.parse(second_period.first))
  end
end
