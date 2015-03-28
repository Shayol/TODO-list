class Project < ActiveRecord::Base

  belongs_to :user
  has_many :tasks, dependent: :destroy
  validates :title, presence: true
  default_scope -> { order('created_at DESC') } #projects retrieved in descending order from newest to oldest
end
