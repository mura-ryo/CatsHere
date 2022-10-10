class Post < ApplicationRecord
  
  validates :title,   presence: true
  validates :body, presence: true, length: { maximum: 500 }
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  
  has_one_attached :image
  
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  # お気に入りしているか判定
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  # 検索方法分岐
  def self.looks(search, word)
   search = "partial_match"
   @post = Post.where("title LIKE?", "%#{word}%")
  end
  
end
