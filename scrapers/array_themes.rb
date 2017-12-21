def array_themes
  page = fetch 'https://array_themes.com/wordpress-themes/'

  # we get all the links for the theme detail page, what they have in common
  # is an anchor tag 'a' with class 'post-featured-image', then with the map
  # function we automatically get a array out of them
  theme_links = page.css('a.post-featured-image').map { |link| link['href'] }

  # debug
  # pp theme_links

  # for each link we go and fetch its details
  themes = []
  theme_links.each do |link|
    page = fetch link

    # grabing name (to find the css selector use google chrome inspect)
    name = page.at_css('h2.entry-title').text

    # preparing the url
    url = link
    puts '+ processing: ' + url

    # grabing the demo_url
    demo_url = page.at_css('.theme-hero-buttons > a:nth-child(2)').attr('href')
    # grabing the price
    raw_price = page.at_css('.offers > span:nth-child(2)').text

    # we test the regex for a number with 1 to 3 digits,
    # if present we extract it
    match_data = /[\d]{1,3}/.match(raw_price)
    price = if match_data
              match_data[0]
            else
              0
            end

    # grabing the description, we remove all html and just extract the text

    description = page.at_css('div.post-text')
    description = Sanitize.fragment(description)
    description.strip!

    changelog_file_url = page.at_css('.download-details > li:nth-child(3) > a')
    changelog_file_url = changelog_file_url.page.attr('href')
    created = ''
    File.each_line(changelog_file_url) do |line|
      created = line if line['= 1.0 -']
    end

    # grabing the created and updated dates
    # created = page.at_css('div.single-theme-details').at_css('td:nth-child(2)')
    # created = created.text

    # updated = created # as there is only updated info datas in anariel_design

    # we add it to our themes array of hashes
    themes << { name: name,
                url: url,
                demo_url: demo_url,
                price: price,
                description: description,
                created: created,
                updated: updated }

    # while testing the consistency of the data,
    # it's useful to fetch only one theme
    # break
  end
  inform(:failed, __method__)
  themes
end
