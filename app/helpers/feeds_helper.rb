module FeedsHelper
	include ActsAsTaggableOn::TagsHelper

	def retrieve_thumbnail(feedlist)

	  @feedlist = feedlist

  	begin

      @object = LinkThumbnailer.generate(@feedlist.url)
      @img_url = @object.images.last.to_s 
      #preview of the website? I dont know if we have to help us
      @url = @feedlist.url
      @preview = Onebox.preview(@url)

    rescue

      @img_url = @feedlist.image
        
    end

    html_string = image_tag(@img_url, height: '50', width: '66').html_safe
    return html_string

	end

  def imagex(summary)
    
    @doc = Nokogiri::HTML(summary)

    puts "SHOW DOC: #{@doc}"
    @doc.css('img').each do |node|
      
      node.each do |attr,attr_val|
        if attr == "src"
          puts "ECCOLOOOOOOOOOOOO#{attr_val}" 
        end
      end
    end
  
  end

  def retrieve_image(summary)
    
    @doc = Nokogiri::HTML(summary)

    puts @doc
    @doc.css('img').each do |node|
      @node_string = node.to_s
      node.each do |attr,attr_val|
        if (attr == "width" && attr_val.to_i > 500) || (attr == "height" && attr_val.to_i > 250)
          @a = 0
          attr == "width" ? @node_string = @node_string.gsub("#{attr_val}", "500") : @node_string = @node_string.to_s.gsub("#{attr_val}", "250")
        end
        if @a == 0
          puts "NUOVO NODO #{@node_string}"
          return @node_string.html_safe
        end
      end
    end
  end

end