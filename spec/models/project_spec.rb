require "rails_helper"

describe Project do
  it "has many tasks" do
    expect(subject).to have_many :tasks
  end

  it "calculates total size" do
    project = FactoryGirl.create(:project)
    project.tasks = [ FactoryGirl.build(:task, size: 1),
                      FactoryGirl.build(:task, size: 6),
                      FactoryGirl.build(:task, size: 7) ]

    expect(project.total_size).to eq 14
  end
end
