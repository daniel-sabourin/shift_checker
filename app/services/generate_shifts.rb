class GenerateShifts
  def self.call(
    start_date: Date.current,
    end_date: 1.year.from_now,
    days_on: 4,
    days_off: 4
  )
    new(start_date: start_date, end_date: end_date, days_on: days_on, days_off: days_off).call
  end

  def initialize(start_date:, end_date:, days_on:, days_off:)
    @start_date = start_date
    @end_date = end_date
    @days_on = days_on
    @days_off = days_off
  end

  def call
    array = []

    starting = start_date

    until starting >= end_date
      array << (starting..starting + (days_on - 1))
      starting = starting + days_on + days_off
    end

    array
  end

  private

  attr_reader :start_date, :end_date, :days_on, :days_off
end
