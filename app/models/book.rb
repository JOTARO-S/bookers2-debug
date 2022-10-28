class Book < ApplicationRecord
  belongs_to :user
  has_many :book_comments,dependent: :destroy
  has_many :favorites,dependent: :destroy
  
  validates :title,presence:true
  validates :body,presence:true,length:{maximum: 200}
  
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
    #User検索機能
  
  def self.looks(search, word)
    if search == "perfect_match"
      @book = Book.where("title LIKE?", "#{word}")
    elsif search == "partial_match"
      @book = Book.where("title LIKE?", "%#{word}%")
    else
      @book = Book.all
    end
  end
  
  scope :created_today, -> { where(created_at: Time.current.all_day) }
  scope :created_yesterday, -> { where(created_at: Time.zone.yesterday.all_day) }
  scope :created_thisweek, -> { where(created_at: Time.current.all_week) }
  scope :created_lastweek, -> { where(created_at: Time.current.last_week.all_week) }
  
end
