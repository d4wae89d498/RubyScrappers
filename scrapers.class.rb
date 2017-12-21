class Scrapers
    def initialize(site_url, themes_a_css, args)
         @site_url = site_url
         @themes_a_css = themes_a_css
         
         defaults ={name_css: nil,
                    demo_url_css: nil, 
                    raw_price_css: nil,
                    desc1_css: nil,
                    desc2_css: nil,
                    updated_css: nil,
                    created_css: nil,
                    changelog_a_css: nil}
                        
         args = defaults.merge(args)
         @args = args
    end
    
    def process
          page = fetch @site_url
        
          # we get all the links for the theme detail page, what they have in common
          # is an anchor tag 'a' with class 'theme-name', then with the map function we
          # automatically get a array out of them
          theme_links = page.css( @themes_a_css).map { |link| link['href'] }
        
          # for each link we go and fetch its details
          themes = []
          theme_links.each do |link|
            page = fetch link
            url = link
            puts '+ processing: ' + url
            
            name=url=demo_url=price=description=created=created=updated=nil
            
            if(@args[:name_css] != nil) then
               name = page.at_css(@args[:name_css]).text 
            end
            
            if(@args[:demo_url_css] != nil) then
                demo_url = page.at_css(@args[:demo_url_css]).attr('href')
            end
            
            if(@args[:raw_price_css] != nil) then
                raw_price = page.at_css(@args[:raw_price_css]).text
            end
            
            if(@args[:desc1_css] != nil) then
                description1 = Sanitize.fragment(page.at_css(@args[:desc1_css]).to_s)
                description1.strip!
            end
            
            description = description1
            if(@args[:desc2_css] != nil) then
                description2 = Sanitize.fragment(page.at_css(@args[:desc2_css]).to_s)
                description2.strip!
                description = description + description2
            end
            
            if(@args[:updated_css] != nil) then
                updated = page.at_css(@args[:updated_css]).text
            end
            
            if(@args[:created_css] != nil) then
                updated = page.at_css(@args[:created_css]).text
            end
            
            themes << { name: name,
                url: url,
                demo_url: demo_url,
                price: price,
                description: description,
                created: created,
                updated: updated }
            
        end
        return themes
    end
end