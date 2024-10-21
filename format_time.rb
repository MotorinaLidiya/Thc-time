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

  def call
    valid? ? [200, formatted_time] : [400, error_message]
  end

  private
  
  def valid?
    invalid_formats.empty?
  end
  
  def formatted_time
    @formats.map { |f| Time.now.strftime(FORMATS[f]) }.join('-')
  end

  def invalid_formats
    @invalid_formats ||= @formats - FORMATS.keys
  end

  def error_message
    "Unknown time format: [#{invalid_formats.join(', ')}]"
  end
end
