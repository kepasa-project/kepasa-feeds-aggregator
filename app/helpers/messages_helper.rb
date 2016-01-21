module MessagesHelper
  def recipients_options
    s = ''
    current_user.following.each do |user|
      s << "<option value='#{user.id}'>#{user.username}</option>"
    end
    s.html_safe
  end

  def gravatar_for(user, size = 30, title = user.username)
    # we use gravastic gem
  	image_tag user.gravatar_url(:size => 30), title: title, class: 'img-rounded'
  end

end