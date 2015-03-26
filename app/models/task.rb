class Task < ActiveRecord::Base
  belongs_to :project
  validates :content, presence: true

  default_scope -> { order('priority ASC') } #tasks retrieved in descending order from task with highest to lowest(1..lowest) priority

  def deadline_formatted
    data = self.deadline.to_s
    data[5...10]
  end
end
