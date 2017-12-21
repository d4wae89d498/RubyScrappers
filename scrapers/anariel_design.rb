def anariel_design
  page = fetch 'https://anarieldesign.com/themes/'

  # we get all the links for the theme detail page, what they have in common
  # is an anchor tag 'a' with two classes '.button' & '.light', then with the map
  # function we automatically get a array out of them
  theme_links = page.css('a.button.light').map { |link| link['href'] }

  # debug
  # pp theme_links

  # for each link we go and fetch its details
  themes = []
  theme_links.each do |link|
    page = fetch link

    # grabing name (to find the css selector use google chrome inspect)
    name = page.at_css('h1.entry-title').text

    # preparing the url
    url = link
    puts '+ processing: ' + url

    # grabing the demo_url
    demo_url = page.at_css('a:nth-child(1).button').attr('href')

    # grabing the price
    raw_price = page.at_css('.plan_price > strong').text

    # we test the regex for a number with 1 to 3 digits,
    # if present we extract it
    match_data = /[\d]{1,3}/.match(raw_price)
    price = if match_data
              match_data[0]
            else
              0
            end

    # grabing the description, we remove all html and just extract the text

    description = page.at_css('div.one_third.lastcolumn')
    description = description.at_css('p:nth-child(2)').to_s
    subdesc = page.at_css('div.one_third.lastcolumn').at_css('p:nth-child(3)')
    subdesc = subdesc.to_s

    description = Sanitize.fragment(description + subdesc)
    description.strip!

    # grabing the created and updated dates
    created = page.at_css('div.single-theme-details').at_css('td:nth-child(2)')
    created = created.text

    updated = created # as there is only updated info datas in anariel_design

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
