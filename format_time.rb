class FormatTime
  FORMATS = {
    year: '%Y',
    month: '%m',
    day: '%d',
    hour: '%H',
    minute: '%M',
    second: '%S'
  }.freeze

  def initialize(format_query)
    @formats = format_query&.split(',')&.map(&:to_sym) || []
  end
  
  def valid?
    invalid_formats.empty?
  end
  
  def formatted_time
    @formats.map { |f| Time.now.strftime(FORMATS[f]) }.join('-')
  end

  def invalid_formats
    @invalid_formats ||= @formats - FORMATS.keys
  end
end
