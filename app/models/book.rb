class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.looks(search, word)
    if search == "perfect"
      @books = Book.where("title LIKE?", "#{word}")
    elsif search == "forward"
      @books = Book.where("title LIKE?", "#{word}%")
    elsif search == "backward"
      @books = Book.where("title LIKE?", "%#{word}")
    elsif search == "partial"
      @books = Book.where("title LIKE?", "%#{word}%")
    end
  end
  
end
