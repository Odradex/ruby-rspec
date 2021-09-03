# frozen_string_literal: true

require_relative '../lib/time_intervals'
require 'rspec'

describe TimeIntervals do
  let(:standard_input) do
    [['10:00', '10:20'], ['10:40', '11:00'], ['10:50', '12:00'], ['12:00', '13:00'], ['10:00', '10:20']]
  end

  context 'overlap? method' do
    it 'checks if time periods overlap' do
      period1 = ['11:00', '15:00']
      period2 = ['13:00', '20:00']
      expect(TimeIntervals.new(nil).overlap?(period1, period2)).to eq(true)
    end

    it 'checks if time periods don\'t overlap' do
      period1 = ['11:00', '12:00']
      period2 = ['13:00', '14:00']
      expect(TimeIntervals.new(nil).overlap?(period1, period2)).to eq(false)
    end
  end

  context 'unite_periods method' do
    it 'checks standard input' do
      expect(TimeIntervals.new(standard_input).unite_periods).to eq([['10:00', '10:20'], ['10:40', '13:00']])
    end
    it 'checks single period' do
      expect(TimeIntervals.new([['12:30', '16:00']]).unite_periods).to eq([['12:30', '16:00']])
    end
  end

end
