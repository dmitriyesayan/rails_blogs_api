class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :subcomments, through: :appointments

  validates :content, presence: true
end
