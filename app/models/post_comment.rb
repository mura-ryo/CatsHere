class PostComment < ApplicationRecord

  belongs_to :user
  belongs_to :post

  validates :comment, presence: true, length: { minimum: 1,maximum: 50 }

end
