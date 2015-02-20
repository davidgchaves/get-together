require "rails_helper"

describe Task do
  it "belongs to a project" do
    expect(subject).to belong_to :project
  end
end
