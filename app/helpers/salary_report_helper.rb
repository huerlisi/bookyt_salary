module SalaryReportHelper
  def duration_from(employment, value_period)
    return value_period.first if employment.duration_from.nil?

    [value_period.first, employment.duration_from].max
  end

  def duration_to(employment, value_period)
    return value_period.last if employment.duration_to.nil?

    [value_period.last, employment.duration_to].min
  end
end
