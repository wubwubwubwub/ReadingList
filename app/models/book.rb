class Book < ActiveRecord::Base
  has_many :book_genres
  has_many :genres, through: :book_genres
  
  scope :finished, ->{ where.not(finished_on: nil) }
  scope :search, ->(keyword){ where( 'keywords LIKE?', "%#{keyword.downcase}%") if keyword.present? }
  # scope :recent, ->{ where('finished_on > ?', 2.days.ago) }
  
  before_save :set_keywords
  
  #def self.search(keyword)
  #  if keyword.present?
  #    where(title: keyword)
  #  else
  #    all
  #  end
  #end

  def self.recent
    where('finished_on > ?', 2.days.ago)
  end
  
  def finished?
    finished_on.present?
  end
  
  protected
  def set_keywords
    self.keywords = [title, author, description].map(&:downcase).join(' ')
  end
  
end
