class Idea < ApplicationRecord
    belongs_to :user
    has_many :likes, dependent: :destroy
    has_many :likers, through: :likes, source: :user

    has_many :reviews, dependent: :destroy

    validates(:title, presence: true, uniqueness: true)

    validates(
      :description,  presence: { message: "must exist" },
              length: { minimum: 5 }
    )
end
