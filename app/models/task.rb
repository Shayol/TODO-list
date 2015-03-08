class Task < ActiveRecord::Base
  belongs_to :project
  validates :content, presense: true
  validates :priority, numericality: {:greater_than: 0}

  default_scope -> { order('priority DESC') } #tasks retrieved in descending order from task with highest to lowest(1..lowest) priority
end
