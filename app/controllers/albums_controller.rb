
class AlbumsController < ApplicationController

    def new
        @album = Album.new
        flash[:band_id] = params[:band_id]
        render :new
    end

    def create
        @album = Album.new(album_params)
        @album.band_id = flash[:band_id]
        if @album.save
            redirect_to band_url(Band.find(@album.band_id))
        else
            flash.now[:errors] = @album.errors.full_messages
            flash[:band_id] = @album.band_id
            render :new
        end  
    end

    def edit
        @album = Album.find_by(id: params[:id])
        render :edit
    end

    def update
        @album = Album.find_by(id: params[:id])
        if @album.update_attributes(album_params)
            redirect_to album_url(@album)   
        else
            flash.now[:errors] = @album.errors.full_messages
            render :edit
        end
    end

    def show
        @album = Album.find_by(id: params[:id])
        render :show
    end

    def destroy
        @album = Album.find_by(id: params[:id])
        band = Band.find(@album.band_id)
        @album.destroy
        flash[:deleted_album] = "Deleted Album: #{@album.title}"
        redirect_to band_url(band)
    end

    private

    def album_params
        params.require(:album).permit(:title, :year, :studio_album)
    end

end