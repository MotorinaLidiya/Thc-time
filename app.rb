class App
  def call(env)
    request = Rack::Request.new(env)
    format_query = request.params['format']
    status, body = FormatTime.new(format_query).call

    response(status, body)
  end

  private

  def response(status, body)
    [
      status,
      { 'Content-Type' => 'text/plain' },
      [body]
    ]
  end
end
