
class Note < ApplicationRecord
    validates :text, presence: true

    belongs_to :user
    belongs_to :track

end