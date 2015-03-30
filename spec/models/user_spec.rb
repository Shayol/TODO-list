require 'rails_helper'
RSpec.describe User, type: :model do

  it { should have_many(:projects) }
  it { should have_many(:tasks).through(:projects) }

end
