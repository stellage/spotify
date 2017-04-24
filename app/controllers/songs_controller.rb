class SongsController < ApplicationController
  def new
    @song = Song.new
    @song.playlist = Playlist.find(params[:playlist_id])
  end

  def create
    @song = Song.create(name: song_params[:name], artist: song_params[:artist])
    @song.playlist = Playlist.find(params[:playlist_id])
    @song.playlist.songs << @song
    if @song.in_spotify? && @song.save
      redirect_to "/playlists/#{params[:playlist_id]}"
    else
      render :new
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
