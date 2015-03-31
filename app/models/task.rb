class Task < ActiveRecord::Base
  belongs_to :project
  validates :content, presence: true, uniqueness: { scope: :project_id }

  default_scope -> { order('priority ASC') }

  def deadline_formatted
    data = self.deadline.to_s
    data[0...10]
  end
end
