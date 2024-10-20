class TimeApp
  FORMATS = {
    year: '%Y',
    month: '%m',
    day: '%d',
    hour: '%H',
    minute: '%M',
    second: '%S'
  }.freeze

  def call(env)
    request = Rack::Request.new(env)

    if request.path_info == '/time'
      time_request(request)
    else
      response(404, 'Not Found')
    end
  end

  private

  def time_request(request)
    format_query = request.params['format']

    return response(400, 'Format is missing') unless format_query

    formats = format_query.split(',').map(&:to_sym)
    unknown_formats = formats - FORMATS.keys

    return response(400, "Unknown time format: [#{unknown_formats.join(', ')}]") unless unknown_formats.empty?

    formatted_time = formats.map { |f| Time.now.strftime(FORMATS[f]) }.join('-')
    response(200, formatted_time)
  end

  def response(status, body)
    [
      status,
      { 'Content-Type' => 'text/plain' },
      [body]
    ]
  end
end
