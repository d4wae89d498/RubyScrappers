require './external_requires'
require './reusable_code'

# get request sur le root
get '/' do
  'Hello World!'
end

# exemple: http://themesapi.herokuapp.com/theme/accesspress_themes
get '/theme/:name' do
  name = params[:name]

  if File.file? "./scrapers/#{name}.rb"
    load "./scrapers.class.rb"
    load "scrapers/#{name}.rb"
    themes = send(name)

    # we define the return type as json data
    content_type :json
    # now we finally return our themes array as json data
    themes.to_json
  else
    status 404
  end
end
