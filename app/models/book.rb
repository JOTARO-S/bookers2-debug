class Book < ApplicationRecord
  belongs_to :user
  has_many :book_comments,dependent: :destroy
  has_many :favorites,dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  
  has_many :view_counts,  dependent: :destroy
  
  validates :title,presence:true
  validates :body,presence:true,length:{maximum: 200}
  validates :tag,presence:true
  validates :star,presence:true
  
  
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
  
  def self.looks(search, word)
    @book = Book.where(["tag LIKE?", "#{word}"])
  end
  
  
  
  scope :created_today, -> { where(created_at: Time.current.all_day) }
  scope :created_yesterday, -> { where(created_at: Time.zone.yesterday.all_day) }
  scope :created_2days, -> { where(created_at: 2.days.ago.all_day) }
  scope :created_3days, -> { where(created_at: 3.days.ago.all_day) }
  scope :created_4days, -> { where(created_at: 4.days.ago.all_day) }
  scope :created_5days, -> { where(created_at: 5.days.ago.all_day) }
  scope :created_6days, -> { where(created_at: 6.days.ago.all_day) }
  scope :created_thisweek, -> { where(created_at: Time.current.all_week) }
  scope :created_lastweek, -> { where(created_at: Time.current.last_week.all_week) }
  scope :created_1week, -> { where(created_at: 1.week.ago.beginning_of_day...Time.zone.now.end_of_day) }


end
