require 'rails_helper'

describe 'Projects' do

  let!(:user) { create(:user) }
  before { sign_in (user) }

  describe 'Create', js: true do
    it 'creates new project' do
      click_on 'new_project_link'
      fill_in 'project_title', with: "Allohomora!"   #find edit_project_
      click_on 'Create project'
      expect(page).to have_content "Allohomora!"
    end
  end

  describe 'Update', js: true do
    it 'updates project' do
      project = create(:project, user: user)
      visit root_path
      find("#project_row_#{project.id}").find("a:first-of-type").click
      fill_in 'project_title', with: 'Beetle juice'
      click_on 'Edit'
      expect(page).to have_content 'Beetle juice'
    end
  end

  describe 'Destroy', js: true do
    it 'deletes project' do
      project = create(:project, user: user)
      visit root_path
      find("#project_row_#{project.id}").find("a[data-method='delete']").click
      a = page.driver.browser.switch_to.alert
      a.accept
      expect(page).not_to have_content project.title
    end
  end

end