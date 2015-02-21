require "rails_helper"

describe CreatesProject do

  describe "build" do
    let(:creator) { CreatesProject.new project_arguments_hash }

    context "with no project name" do
      let(:project_arguments_hash) { {} }
      before(:example) { creator.build }

      it "creates the project" do
        expect(creator.project.name).to eq ""
      end
    end

    context "with a given project name" do
      let(:project_arguments_hash) { { name: "Project Runway" } }
      before(:example) { creator.build }

      it "creates the project" do
        expect(creator.project.name).to eq "Project Runway"
      end
    end
  end

  describe "task string parsing" do
    let(:creator) { CreatesProject.new name: "Test", task_string: task_string }
    let(:tasks) { creator.convert_string_to_tasks }

    context "when handling an empty string" do
      let(:task_string) { "" }

      it "doesn't add any task" do
        expect(tasks.size).to eq 0
      end
    end

    context "when handling a single string with no size" do
      let(:task_string) { "Start things" }

      it "adds a task with the right title and a default size of 1" do
        expect(tasks).to match [
          an_object_having_attributes(title: "Start things", size: 1)
        ]
      end
    end

    context "when handling a single string with 0 size" do
      let(:task_string) { "Start things:0" }

      it "adds a task with the right title and a default size of 1" do
        expect(tasks).to match [
          an_object_having_attributes(title: "Start things", size: 1)
        ]
      end
    end

    context "when handling a single string with size" do
      let(:task_string) { "Start things:3" }

      it "adds a task with the right title and size" do
        expect(tasks).to match [
          an_object_having_attributes(title: "Start things", size: 3)
        ]
      end
    end

    context "when handling a multiline string" do
      let(:task_string) { "Start things:3\nIn process\nFinish things:6" }

      it "adds all the tasks with the right titles and sizes" do
        expect(tasks).to match [
          an_object_having_attributes(title: "Start things", size: 3),
          an_object_having_attributes(title: "In process", size: 1),
          an_object_having_attributes(title: "Finish things", size: 6)
        ]
      end
    end
  end

  describe "creation" do
    let(:creator) { CreatesProject.new name: "Test", task_string: "Start things:3\nIn process\nFinish things:6" }
    before(:example) { creator.create }

    it "attaches the tasks to the project" do
      expect(creator.project.tasks.size).to eq 3
    end

    it "saves the project" do
      expect(creator.project).not_to be_a_new_record
    end
  end

end
