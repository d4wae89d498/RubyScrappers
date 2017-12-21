def accesspress_themes
  page = fetch 'https://accesspressthemes.com/wordpress-themes/'

  # we get all the links for the theme detail page, what they have in common
  # is an anchor tag 'a' with class 'detail', then with the map function we
  # automatically get a array out of them
  theme_links = page.css('a.detail').map { |link| link['href'] }

  # debug
  # pp theme_links

  # for each link we go and fetch its details
  themes = []
  theme_links.each do |link|
    page = fetch link

    # grabing name (to find the css selector use google chrome inspect)
    name = page.at_css('#content > div.main-title > h1 > span').text

    # preparing the url
    url = link
    puts '+ processing: ' + url

    # grabing the demo_url
    demo_url = page.at_css('div.sales-button.clearfix > a:nth-child(1)')['href']

    # grabing the price
    raw_price = page.at_css('ul.details span[itemprop=price]').text

    # we test the regex for a number with 1 to 3 digits
    # if present we extract it
    match_data = /[\d]{1,3}/.match(raw_price)
    price = if match_data
              match_data[0]
            else
              0
            end

    # grabing the description, we remove all html and just extract the text
    description = Sanitize.fragment(page.at_css('div.intro').to_s)

    # grabing the created and updated dates
    created = page.at_css('ul.details li:nth-child(3)').text
    # we remove remove everything other then the date
    created.gsub!('Release Date', '')
    # the strip always comes at the end
    created.strip!

    updated = page.at_css('ul.details li:nth-child(4)').text
    updated.gsub!('Latest Update', '')
    updated.gsub!('Update Logs', '')
    updated.strip!

    # we add it to our themes array of hashes
    themes << { name: name,
                url: url,
                demo_url: demo_url,
                price: price,
                description: description,
                created: created,
                updated: updated }
  end
  
  inform(:ok, __method__)
end
