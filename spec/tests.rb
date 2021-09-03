require_relative '../lib/time_intervals.rb'

describe TimeIntervals do
  it 'checks if time periods overlap' do
    period1 = ['11:00', '15:00']
    period2 = ['13:00', '20:00']
    expect(TimeIntervals.new(nil).overlap?(period1, period2)).to eq(true)
  end
end
