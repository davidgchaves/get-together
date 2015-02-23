require "rails_helper"

describe ProjectsController, type: :controller do

  describe "GET new" do
    before(:example) { get :new }

    it "assigns a new project to @project" do
      expect(assigns(:project)).to be_a_new Project
    end

    it "renders the :new template" do
      expect(response).to render_template :new
    end
  end

  describe "POST create" do
    context "with valid project data" do
      let(:valid_action) { instance_double CreatesProject, create: true }
      let(:project_params_data) { { name: "Runway", task_string: "Start something:2" } }

      before(:example) do
        allow(CreatesProject).to receive(:new)
          .with(project_params_data)
          .and_return valid_action
        post :create, project: { name: "Runway", tasks: "Start something:2" }
      end

      it "commands CreateProject to initialize the project with data from params" do
        expect(CreatesProject).to have_received(:new).with project_params_data
      end

      it "commands CreateProject to actually persist the project" do
        expect(valid_action).to have_received(:create)
      end

      it "redirects to projects#index" do
        expect(response).to redirect_to projects_path
      end
    end

    context "with invalid project data" do
      let(:invalid_action) { instance_double CreatesProject, create: false, project: Project.new }
      let(:project_params_data) { { name: "", task_string: "" } }

      before(:example) do
        allow(CreatesProject).to receive(:new)
          .with(project_params_data)
          .and_return invalid_action
        post :create, project: { name: "", tasks: "" }
      end

      it "assigns the existing project data to @project" do
        expect(assigns(:project)).to match invalid_action.project
      end

      it "re-renders the :new template" do
        expect(response).to render_template :new
      end
    end
  end

end
