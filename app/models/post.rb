class Post < ApplicationRecord
	has_many :comments, as: :commentable

	#This validates presence of title, and makes sure that the length is not more than 140 words
  validates :title, presence: true, length: {maximum: 140}
  #This validates presence of body
  validates :body, presence: true
  #This validates format of URL
  #validates :url, :format => URI::regexp(%w(http https))
end
