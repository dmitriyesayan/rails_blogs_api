class Post < ApplicationRecord

  default_scope { order(position: :asc) }

  has_many :comments, dependent: :destroy
  has_many :subcomments, through: :appointments

  validates :content, presence: true, length: { minimum: 3 }
end
