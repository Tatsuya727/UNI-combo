Datadog.configure do |c|
    c.use :rails, service_name: 'UNI-combo', log_injection: true
    c.use :active_record, orm_service_name: 'my-rails-app-postgres'
    c.tracer env: Rails.env, tags: { 'env' => Rails.env }
    c.tracer.enabled = true
end
