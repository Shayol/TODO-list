require 'rails_helper'
RSpec.describe Task, type: :model do

  it { should belong_to(:project) }
  #subject { FactoryGirl.create(:task) }
  it { should validate_uniqueness_of(:content).scoped_to(:project_id) }
end
