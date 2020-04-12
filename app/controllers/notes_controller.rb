
class NotesController < ApplicationController

    before_action :send_to_login
    before_action :own_note?, only: [:destroy]

    def create
        @note = Note.new(note_params)
        @note.user_id = current_user.id
        @note.save
        redirect_to track_url(Track.find(@note.track_id))
    end

    def destroy
        @note = Note.find_by(id: params[:id])
        track = Track.find(@note.track_id)
        @note.destroy
        redirect_to track_url(track)
    end

    private

    def note_params
        params.require(:note).permit(:text, :track_id)
    end

    def own_note?
        note = Note.find_by(id: params[:id])
        if note.user_id != current_user.id
            render plain: "That's not your note", status: :forbidden
        end
    end
end