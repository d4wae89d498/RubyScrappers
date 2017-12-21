def acosmin
  args = {name_css: 'h1.tmi-name',
          demo_url_css: 'a:nth-child(2).ac-btn', 
          desc1_css: 'h2.tmi-description',
          updated_css: '.tmi-info > ul > li:nth-child(3)',
          created_css: '.tmi-info > ul > li:nth-child(3)'}
          
  scrapers = Scrapers.new('http://www.acosmin.com/premium-wordpress-themes/','a.theme-name', args)
  ret = scrapers.process
  inform(:ok, __method__)
  ret
end
