module HomeHelper
  def playlist_button_attributes
    classes = %w[ btn btn-dark text-success px-5 my-5 ]
    classes << "text-decoration-line-through" unless spotify_user_authenticated?

    attributes = Hash.new
    attributes[:params] = { songs: @songs }
    attributes[:class] = classes.join(" ")
    attributes[:type] =  "button"
    attributes[:data] = { turbo: false }
    attributes
  end

  def song_class(song)
    album = @albums.select { |a| a.tracks.include?(song) }.first
    return "text-light" if album.nil?

    "zfm-text-#{album.color}"
  end
end
