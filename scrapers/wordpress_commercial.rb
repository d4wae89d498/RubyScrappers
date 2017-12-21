def wordpress_commercial
  # setting marketplace value
  wordpress_commercial = Marketplace.find_by(name: :wordpress_commercial)
  page = get_page 'https://wordpress.org/themes/commercial/'

  page.css('div#themes > div.theme-browser > div.themes > article.theme').each do |node|
    name = node.at_css('h3').text.squish.parameterize(separator: '_').tr('-', '_')
    url = node.at_css('a')[:href].squish
    # puts "#{name} -> #{url}"
    this_provider = Provider.where(name: name).first
    if this_provider.present?
      this_provider.update!(url: url, marketplace: wordpress_commercial)
      print '$ > '
    else
      created = Provider.create(name: name, url: url, marketplace: wordpress_commercial)
      print "$ #{created.name} > "
    end
  end

  inform(:ok, __method__)
end
