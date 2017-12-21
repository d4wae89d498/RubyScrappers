def fetch(url)
  # we define the user agent
  mac_safari = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_3) AppleWebKit/602.4.8 (KHTML, like Gecko) Version/10.0.3 Safari/602.4.8'
  # we do the request
  response = HTTParty.get url, headers: { 'User-Agent': mac_safari }
  # and feed the response body to nokogiri, it is automatically returned
  Nokogiri::HTML response.body
end

def inform(name, calling_method)
  case name
  when :ok
    puts "#{calling_method}: " + "\u2713"
  when :undefined
    puts "#{calling_method}: " + "\u003F"
  when :failed
    puts "#{calling_method}: " + "\u2717"
  end
end
