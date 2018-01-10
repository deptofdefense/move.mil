Rails.application.configure do
  config.action_dispatch.default_headers.merge!(
    'X-UA-Compatible' => 'IE=Edge'
  )
end
