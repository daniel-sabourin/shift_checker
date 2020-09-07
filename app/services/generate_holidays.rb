class GenerateHolidays
  def self.call(
    start_date: Date.current,
    end_date: 1.year.from_now,
    region_code: :ca_ab
  )
    new(start_date: start_date, end_date: end_date, region_code: region_code).call
  end

  def initialize(start_date:, end_date:, region_code:)
    @start_date = start_date
    @end_date = end_date
    @region_code = region_code
  end

  def call
    Holidays.load_custom(Rails.root.join('config', 'ca.yaml'))
    Holidays.between(start_date, end_date, region_code)
  end

  private

  attr_reader :start_date, :end_date, :region_code
end
