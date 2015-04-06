require 'rails_helper'

describe 'Tasks' do

  let!(:user) { create(:user) }
  before { sign_in(user) }

  let!(:project) { create(:project, user: user) }
  #let!(:task) { create(:task, project: project) }

  #before { visit root_path }

  describe 'Edit', js: true do
    it 'updates task' do
      task = create(:task, project: project)
      visit root_path
      find("#task_row_#{task.id}").find("a[href$='edit']").click
      within "#edit_task_#{task.id}" do
        find("#task_content").set("Leviosa!")
      click_on 'Edit task'
      end
      expect(page).to have_content "Leviosa!"
    end
  end

  describe 'Task_completed', js: true do
    it 'marks task as completed' do
      task = create(:task, project: project)
      visit root_path
      within "#task_row_#{task.id}" do
        find(".fa-square-o").click
      end
      expect(page).to have_selector("#task_row_#{task.id} .fa-check-square-o")
    end
  end

  describe 'Not completed', js: true do
    it 'marks task as not completed' do
      task = create(:task, project: project, completed: true)
      visit root_path
      within "#task_row_#{task.id}" do
        find(".fa-check-square-o").click
      end
        expect(page).to have_selector("#task_row_#{task.id} .fa-square-o")
    end
  end

  describe 'Priority_up', js: true do
    it 'gives task higher priority' do
      upper_task = create!(:task, project: project) #priority_up action expects two tasks to exchange values of priorities
      task = create!(:task, project: project, priority: 2)
      visit root_path
      find("#task_row_#{task.id}").find("a[href$='priority_up']").click
      visit root_path
      expect(task.priority).to eq 1
    end
  end

    describe 'Destroy', js: true do
    it 'destroys task' do
      task = create(:task, project: project)
      visit root_path
      within "#task_row_#{task.id}" do
        find("a[data-method='delete']").click
      end
      a = page.driver.browser.switch_to.alert
      a.accept
      expect(page).not_to have_content task.content
    end
  end
end
