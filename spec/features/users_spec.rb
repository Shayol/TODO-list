require 'rails_helper'

describe 'User' do
  let!(:user) { create(:user) }

  it 'successfully authenticates with email' do
    sign_in (user)
    expect(page).to have_content 'sign out'
  end

end