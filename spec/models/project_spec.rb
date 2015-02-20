require "rails_helper"

describe Project do
  it "has many tasks" do
    expect(subject).to have_many :tasks
  end
end
