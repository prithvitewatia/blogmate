class Comment < ApplicationRecord
  belongs_to :blog_post
  belongs_to :user

  validates :body, presence: true,
            length: {in: 1..100,
                     too_short: "Minimum %{count} characters required",
                     too_long: "Maximum %{count} characters allowed"}
end
