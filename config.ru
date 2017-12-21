require './main' # using the appp
configure do
  set :protection, except: [:authenticity_token, :form_token, :json_csrf, :remote_referrer, :form_token, :escaped_params, :frame_options, :path_traversal, :session_hijacking, :ip_spoofing]
end
run Sinatra::Application
