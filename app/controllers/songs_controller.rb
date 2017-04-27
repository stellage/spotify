class SongsController < ApplicationController
  def new
    @song = Song.new
    @song.playlist = Playlist.find(params[:playlist_id])
  end

  def create
    @song = Song.new(name: song_params[:name], artist: song_params[:artist])
    @song.playlist = Playlist.find(params[:playlist_id])
    if @song.in_spotify?
      @song.save
      @song.playlist.songs << @song
      redirect_to "/playlists/#{params[:playlist_id]}"
    else
      p "WAS NOT IN SPOTIFY"
      redirect_to new_playlist_song_path, notice: 'song was not in spotify'
    end
  end

  def show
  	@song = Song.find(params[:id])
  end

  def destroy
    Song.find(params[:id]).destroy
    redirect_to "/playlists/#{params[:playlist_id]}", notice: 'song was successfully destroyed.'
  end

  def song_params
    params.require(:song).permit(:name, :artist)
  end
end
