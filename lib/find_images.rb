class FindImages

 def self.retrieve_image(summary)
   
 @doc = Nokogiri::HTML(summary)

 @doc.css('img').each do |node|    
   node.each do |attr,attr_val|
     if attr == "src"
       @attr_val = attr_val
     else
       @attr_val = nil
     end
   end
 end

 return @attr_val

 end

end

