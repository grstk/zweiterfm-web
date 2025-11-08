module HomeHelper
  def playlist_button_attributes
    classes = %w[ btn btn-dark ]
    classes << "text-decoration-line-through" unless spotify_user_authenticated?

    attributes = Hash.new
    attributes[:class] = classes.join(" ")
    attributes[:disabled] = !spotify_user_authenticated?
    attributes[:type] =  "button"
    attributes
  end
end
