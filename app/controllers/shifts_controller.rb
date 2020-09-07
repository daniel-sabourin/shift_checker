class ShiftsController < ApplicationController
  def index
    @start_date  = Date.parse(params[:start_date].presence  || Date.current.to_s)
    @end_date    = Date.parse(params[:end_date].presence    || 1.year.from_now.to_date.to_s)
    @days_on     = (params[:days_on].presence     || 4).to_i
    @days_off    = (params[:days_off].presence    || 4).to_i
    @region_code = (params[:region_code].presence || :ca_ab)

    @shifts = GenerateShifts.call(
      start_date: @start_date,
      end_date: @end_date,
      days_on: @days_on,
      days_off: @days_off
    )

    @holidays = GenerateHolidays.call(
      start_date: @start_date,
      end_date: @end_date,
      region_code: @region_code
    )

    @shift_holidays = @holidays.select do |holiday|
      @shifts.any? { |shift| shift.include?(holiday[:date]) }
    end

    @unshift_holidays = @holidays - @shift_holidays
  end
end
