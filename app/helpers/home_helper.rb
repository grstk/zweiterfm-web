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

  def song_classes(song)
    classes = []
    album = @albums.select { |a| a.tracks.include?(song) }.first
    album.present? ? classes << "zfm-text-#{album.color}" : classes << "text-light"
    return classes.join(" ") unless @past_songs.present?
    return classes.join(" ") if @past_songs.include?(song)

    classes << "bg-black"
    classes.join(" ")
  end
end
