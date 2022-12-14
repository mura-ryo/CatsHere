class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :email, presence: true
  validates :password, length: { minimum: 6 }, presence: true, on: :create

  has_many :posts,          dependent: :destroy
  has_many :post_comments,  dependent: :destroy
  has_many :favorites,      dependent: :destroy

  # DM機能で使う
  has_many :messages, dependent: :destroy
  has_many :entries,  dependent: :destroy

  # フォローをした、されたの関係
  has_many :relationships,            class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  # 一覧画面で使う
  has_many :followings, through: :relationships, source: :followed
  has_many :followers,  through: :reverse_of_relationships, source: :follower

  has_one_attached :profile_image

  def get_profile_image
    (profile_image.attached?) ? profile_image : "no_image.jpg"
  end

  # フォローしたときの処理
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  # フォローを外すときの処理
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  # フォローしているか判定
  def following?(user)
    followings.include?(user)
  end

  # 検索方法分岐
  def self.looks(search, word)
    search = "partial_match"
    @user = User.where("name LIKE?", "%#{word}%")
  end
end
