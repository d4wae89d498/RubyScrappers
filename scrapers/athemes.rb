def athemes
  args = {demo_url_css: '.demo-button-theme:nth-child(1)'}
  scrapers = Scrapers.new('https://athemes.com/wordpress-themes/','.demo-button > a', args)
  scrapers.process
end

