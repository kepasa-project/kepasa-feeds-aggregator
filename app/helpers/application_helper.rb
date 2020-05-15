##
# Module with helper methods usable from all views in the application
module ApplicationHelper

  def retrieve_language(language)

  	case language

  	when 'en'
      'English'
    when 'es'
      'Español'
    when 'it'
      'Italiano'
    when 'tl'
      'Tagalog'
    end
    
  end

end