module HomeHelper
  def spotify_button_attributes
    classes = %w[ btn bg-black px-5 my-5 ]

    attributes = Hash.new
    attributes[:params] = { songs: @songs } if spotify_user_authenticated?
    attributes[:class] = classes.join(" ")
    attributes[:type] =  "button"
    attributes[:data] = { turbo: false }
    attributes
  end

  def song_classes(song)
    classes = %w[ zfm-word-break-all ]
    album = @albums.select { |a| a.tracks.include?(song) }.first
    classes << "zfm-text-#{album.color}"
    return classes.join(" ") unless @past_songs.present?
    return classes.join(" ") if @past_songs.include?(song)

    classes << "bg-black"
    classes.join(" ")
  end
end
