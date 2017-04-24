class PlaylistsController < ApplicationController
  def new
    @playlist = Playlist.new
  end

  def create
    @playlist = Playlist.create(name: playlist_params[:name])
    @playlist.users << current_user
    current_user.playlists << @playlist
    if @playlist.save
      redirect_to current_user
    else
      render :new
    end
  end

  def show
    @playlist = Playlist.find(params[:id])
  end

  def edit
    @playlist = Playlist.find(params[:id])
  end

  def update
    @playlist = Playlist.find(params[:id])
    if @playlist.update(playlist_params)
      redirect_to current_user, notice: 'playlist was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    Playlist.find(params[:id]).destroy
    redirect_to current_user, notice: 'playlist was successfully destroyed.'
  end

  def add_user
    @playlist = Playlist.find(params[:id])
    @playlist.users << current_user
    current_user.playlists << @playlist
    redirect_to "/playlists/#{@playlist.id}"
  end

  # Only allow a trusted parameter "white list" through.
  def playlist_params
    params.require(:playlist).permit(:name)
  end
end
