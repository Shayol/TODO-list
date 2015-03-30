class Project < ActiveRecord::Base

  belongs_to :user
  has_many :tasks, dependent: :destroy

  validates :title, presence: true, uniqueness: { scope: :user_id }

  default_scope -> { order('created_at DESC') }
end
