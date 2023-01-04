class ArtistsController < ApplicationController

  before_action :set_artist, only: %i[ show edit update destroy ]
  helper_method :sort_column, :sort_direction

  def index
    artists = Artist.where(nil)
    artists = Artists.where("title ILIKE ?", "%#{params[:search]}%", "%#{params[:search]}%") if params[:search].present?
    @artists = artists.order(sort_column  +  " " + sort_direction).page(params[:page]) 

    @select_artists = Artist.all.pluck(:title, :id)

    respond_to do |format|
      format.js
      format.html
      format.json
    end
  end

  def new
    @artist = Artist.new


  end

  def create
    @artist = Artist.new(artist_params)
    respond_to do |format|
      if @artist.save
        format.html { redirect_to artist_url(@artist), notice: "artist was successfully created." }
        format.js
      else
        format.html do
          flash.now[:alert] = "artist was not created." 
          render :new, status: :unprocessable_entity
        end
        format.json do 
          render json: @artist.errors, status: :unprocessable_entity
        end
      end
    end
  end

  def edit
  end

  def show
    respond_to do |format|
      format.js
      format.html
      format.json
    end
  end

  def destroy
    @artist.destroy
    
    respond_to do |format|
        format.html { redirect_to artists_url }
        format.json { head :no_content }
        format.js   { render :layout => false }
    end
  end

  private

  def set_artist
    @artist = Artist.find(params[:id])
  end

  def artist_params
    params.require(:artist).permit(:title)
  end

  def sort_column
    Artist.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
