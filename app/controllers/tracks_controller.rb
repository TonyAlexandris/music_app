
class TracksController < ApplicationController

    before_action :send_to_login

    def new
        @track = Track.new
        flash[:album_id] = params[:album_id]
        render :new
    end

    def create
        @track = Track.new(track_params)
        @track.album_id = flash[:album_id]
        if @track.save
            redirect_to album_url(Album.find(@track.album_id))
        else
            flash.now[:errors] = @track.errors.full_messages
            flash[:album_id] = @track.album_id
            render :new
        end  
    end

    def edit
        @track = Track.find_by(id: params[:id])
        render :edit
    end

    def update
        @track = Track.find_by(id: params[:id])
        if @track.update_attributes(track_params)
            redirect_to track_url(@track)   
        else
            flash.now[:errors] = @track.errors.full_messages
            render :edit
        end
    end

    def show
        @track = Track.find_by(id: params[:id])
        render :show
    end

    def destroy
        @track = Track.find_by(id: params[:id])
        album = Album.find(@track.album_id)
        @track.destroy
        flash[:deleted_track] = "Deleted Track: #{@track.title}"
        redirect_to album_url(album)
    end

    private

    def track_params
        params.require(:track).permit(:title, :ord, :bonus_track, :lyrics)
    end

end