class Comment < ApplicationRecord
  include Visible

  belongs_to :blog_post

end
