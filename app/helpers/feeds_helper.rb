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

end
