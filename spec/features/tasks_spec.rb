require 'rails_helper'

describe 'Tasks' do

  let!(:user) { create(:user) }
  before { sign_in(user) }

  let!(:project) { create(:project, user: user) }
  let!(:task) { create(:task, project: project) }

  before { visit root_path }

  describe 'Update', js: true do
    it 'updates task' do
      click_on "edit_icon_task_#{task.id}"
      within "#edit_task_#{task.id}" do
      find(".new-task-input").set("Leviosa!")
      click_on 'Edit task'
    end
      expect(page).to have_content "Leviosa!"
    end
  end

  describe 'Destroy', js: true do
    it 'destroys task' do
      find("#delete_icon_task_#{task.id}").click
      page.driver.browser.switch_to.alert.accept
      expect(page).not_to have_content task.content
    end
  end

  describe 'Task_completed', js: true do
    it 'marks task as completed' do
      within "#task_row_#{task.id}" do
        find(".fa-square-o").click
      end
      expect(page).to have_selector("#task_row_#{task.id} .fa-check-square-o")
    end
  end

  describe 'Not completed', js: true do
    it 'marks task as not completed' do
      task_completed = create(:task, project: project, completed: true)
        within "#task_row_#{task_completed.id}" do
          find(".fa-check-square-o").click
        end
        expect(page).to have_selector("#task_row_#{task_completed.id} .fa-square-o")
    end
  end
end



