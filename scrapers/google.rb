def google 
  keywords = "pomme pomme pomme"
  
  google_url = 'http://google.fr/?gws_rd=ssl#'
  
  keys = keywords.split(/[^[[:word:]]]+/)
  
  keywords = "q="
   
  keys.each_with_index {|val, index|
      
      if keywords.length != 2
      keywords = keywords + "+" + val
      
   else
       keywords = keywords + val
   end
       
  }
      
  keywords =  keywords = keywords +  "&*"
  
  page = google_url + keywords
  
  page = fetch page
  
  
  puts page.to_s
  
  

  # we get all the links for the theme detail page, what they have in common
  # is an anchor tag 'a' with class 'btn btn-theme-black',
  # then with the map function we automatically get a array out of them
  puts 
  return 0
end
