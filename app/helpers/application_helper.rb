module ApplicationHelper
    include ERB::Util

    def auth_token
        html = "<input type=\"hidden\" name=\"authenticity_token\""
        html += "value=\"#{form_authenticity_token}\"/>"
        html.html_safe        
    end

    def ugly_lyrics(lyrics)
        note = "&#9835;".html_safe + " "
        lines_lyrics = lyrics.split("\r\n")
        musical_lyrics_array = []
        lines_lyrics.each do |line|
            new_line = note + h(line)
            musical_lyrics_array << new_line
        end
        musical_lyrics_array.map! {|line| line + "\r\n".html_safe}
        musical_lyrics = safe_join(musical_lyrics_array)
        html = "<pre>".html_safe
        html += musical_lyrics
        html += "</pre>".html_safe
        html
    end
end