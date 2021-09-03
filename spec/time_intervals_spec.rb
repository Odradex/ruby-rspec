# frozen_string_literal: true

require_relative '../lib/time_intervals'
require 'rspec'

describe TimeIntervals do
  let(:standard_input) do
    [['10:00', '10:20'], ['10:40', '11:00'], ['10:50', '12:00'], ['12:00', '13:00'], ['10:00', '10:20']]
  end
  let(:standard_output) do
    [['10:00', '10:20'], ['10:40', '13:00']]
  end

  context 'overlap? method' do
    it 'checks if time periods overlap' do
      period1 = ['11:00', '15:00']
      period2 = ['13:00', '20:00']
      expect(TimeIntervals.new(standard_input).overlap?(period1, period2)).to eq(true)
    end

    it 'checks if time periods don\'t overlap' do
      period1 = ['11:00', '12:00']
      period2 = ['13:00', '14:00']
      expect(TimeIntervals.new(standard_input).overlap?(period1, period2)).to eq(false)
    end
  end

  context 'unite_periods method' do
    it 'checks standard input' do
      expect(TimeIntervals.new(standard_input).unite_periods).to eq(standard_output)
    end
    it 'checks single period' do
      expect(TimeIntervals.new([['12:30', '16:00']]).unite_periods).to eq([['12:30', '16:00']])
    end
    it 'checks two periods' do
      expect(TimeIntervals.new([['16:00', '17:00'], ['12:30', '16:00']]).unite_periods).to eq([['12:30', '17:00']])
    end
    it 'checks unsorted input' do
      expect(TimeIntervals.new(standard_input.shuffle).unite_periods).to eq(standard_output)
    end
  end

  context 'initialize method' do
    it 'checks sub-array size' do
      expect { TimeIntervals.new(standard_input.push(['20:44'])) }.to raise_error(ArgumentError)
    end
    it 'checks time' do
      expect { TimeIntervals.new(standard_input.push(['80:4'])) }.to raise_error(ArgumentError)
    end
  end
end
