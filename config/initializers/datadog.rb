Datadog.configure do |c|
    c.use :rails, service_name: 'UNI-combo', database_service: 'postgresql'
    c.tracer hostname: 'localhost', port: 8126
    c.api_key = ENV['DATADOG_API_KEY']
end
