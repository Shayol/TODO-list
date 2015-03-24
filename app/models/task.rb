class Task < ActiveRecord::Base
  belongs_to :project
  validates :content, presence: true

  default_scope -> { order('priority ASC') } #tasks retrieved in descending order from task with highest to lowest(1..lowest) priority
end
