require 'rails_helper'

RSpec.describe Project, type: :model do

  it { should belong_to(:user) }
  it { should have_many(:tasks).dependent(:destroy) }
  it { should validate_presence_of(:title) }
  it { should validate_uniqueness_of(:title).scoped_to(:user_id) }

end
