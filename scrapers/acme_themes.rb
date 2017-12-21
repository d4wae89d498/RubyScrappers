def acme_themes
 args = {name_css: 'section.page-header > div.container > h1 > span',
          demo_url_css: 'a.btn.btn-theme-orange', 
          raw_price_css: 'p.at-price',
          desc1_css: 'div.details',
          created_css: 'div.item-details > table.acme-col-1 > tr:nth-child(3)'}
          
  scrapers = Scrapers.new('http://www.acmethemes.com/themes/','a.btn-theme-black', args)
  ret = scrapers.process
  inform(:ok, __method__)
  ret
  
end
