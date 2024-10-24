class App
  def call(env)
    request = Rack::Request.new(env)
    format_query = request.params['format']
    response_body(format_query)
  end

  private
  
  def response_body(format_query)
    formatted = FormatTime.new(format_query)
    formatted.valid? ? response(200, formatted.formatted_time) : response(400, "Unknown time format: [#{formatted.invalid_formats.join(', ')}]")
  end

  def response(status, body)
    [
      status,
      { 'Content-Type' => 'text/plain' },
      [body]
    ]
  end
end
