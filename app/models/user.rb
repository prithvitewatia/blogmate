class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :blog_posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :username, presence: true,
            length: {in: 1..16,
                     too_short: "Minimum %{count} character is required",
                     too_long: "Maximum %{count} characters allowed"},
            uniqueness: true

end
