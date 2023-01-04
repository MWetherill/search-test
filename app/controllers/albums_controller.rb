class AlbumsController < ApplicationController
  before_action :set_album, only: %i[ show edit update destroy ]
  helper_method :sort_column, :sort_direction

  def index
    albums = Album.where(nil)
    albums = albums.where("title ILIKE ?", "%#{params[:search]}%", "%#{params[:search]}%") if params[:search].present?
    @albums = albums.order(sort_column  +  " " + sort_direction).page(params[:page]) 
  end

  def new
    @album = Album.new
    @artists = Artist.all.pluck(:title, :id)

  end

  def create
    @album = Album.new(album_params)
    respond_to do |format|
      if @album.save
        format.html { redirect_to album_url(@album), notice: "album was successfully created." }
        format.js
      else
        format.html do
          flash.now[:alert] = "album was not created." 
          render :new, status: :unprocessable_entity
        end
        format.json do 
          render json: @album.errors, status: :unprocessable_entity
        end
      end
    end
  end

  def edit
  end

  def show
  end

  def destroy
    @album.destroy
    
    respond_to do |format|
        format.html { redirect_to albums_url }
        format.json { head :no_content }
        format.js   { render :layout => false }
    end
  end

  private

  def set_album
    @album = Album.find(params[:id])
  end

  def album_params
    params.require(:album).permit(:title, :artist_id)
  end

  def sort_column
    Album.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
