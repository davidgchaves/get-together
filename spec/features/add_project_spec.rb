require "rails_helper"

# Given: We're starting with empty data, so no setup
# When:  Filling out a form with project data and submitting
# Then:  Verifying that the new project shows up on our list of projects
#        with the entered tasks attached

describe "adding projects" do
  it "allows a user to create a project with tasks" do
    visit new_project_path
    fill_in "Name", with: "Project Runway"
    fill_in "Tasks", with: "Task 1:3\nTask 2:5" # 2 tasks sizes 3 and 5
    click_on "Create Project"

    visit project_path
    expect(page).to have_content "Project Runway"
    expect(page).to have_content "8" # total size is 8 (=3+5)
  end
end
