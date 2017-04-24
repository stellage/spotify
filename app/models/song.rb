require 'open-uri'

class Song < ActiveRecord::Base
  belongs_to :playlist

  def song_search
    name_formatted = name.gsub(/\s/, '+')
    artist_formatted = artist.gsub(/\s/, '+')
    name_formatted + '+' + artist_formatted
  end

  def in_spotify?
    data = JSON.load(open('https://api.spotify.com/v1/search?q=' + song_search + '&type=track'))
    return false if data['tracks']['items'].empty?
    true
  end

  def spotify_uri
    data = JSON.load(open('https://api.spotify.com/v1/search?q=' + song_search + '&type=track'))
    return nil if data['tracks']['items'].empty?
    data['tracks']['items'][1]['uri']
  end
end
