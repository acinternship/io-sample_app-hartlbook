module UsersHelper

  # returns the gravatar for the given user
  def gravatar_for(user, options = { size: 80 }) # could be (user, size: 80) too
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size] # size of the gravatar
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar") # returns img tag for grav with grav css class
  end
end
