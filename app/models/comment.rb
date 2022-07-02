class Comment < ApplicationRecord
  belongs_to :post
  has_many :subcomments, dependent: :destroy

  validates :content, presence: true
end
