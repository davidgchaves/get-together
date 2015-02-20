require "rails_helper"

describe CreatesProject do
  it "creates a project with the given name" do
    creator = CreatesProject.new name: "Project Runway"
    creator.build

    expect(creator.project.name).to eq "Project Runway"
  end

  it "creates a project with a blank name when name is not given" do
    creator = CreatesProject.new
    creator.build

    expect(creator.project.name).to eq ""
  end
end
