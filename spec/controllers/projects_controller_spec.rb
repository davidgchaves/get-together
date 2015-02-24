require "rails_helper"

describe ProjectsController, type: :controller do

  describe "GET index" do
    let(:project_collection) { [ double(Project), double(Project)] }

    before(:example) do
      allow(Project).to receive(:all).and_return project_collection
      get :index
    end

    it "assigns the current project collection to @projects" do
      expect(assigns(:projects)).to match project_collection
    end

    it "renders the :index template" do
      expect(response).to render_template :index
    end
  end

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
    let(:action) { instance_double CreatesProject }
    let(:project_params_data) { { name: "Runway", task_string: "Start something:2" } }

    before(:example) do
      allow(CreatesProject).to receive(:new)
        .with(project_params_data)
        .and_return action
      allow(action).to receive(:create).and_return true
      post :create, project: { name: "Runway", tasks: "Start something:2" }
    end

    it "commands CreateProject to initialize the project with data from params" do
      expect(CreatesProject).to have_received(:new).with project_params_data
    end

    it "commands CreateProject to actually persist the project" do
      expect(action).to have_received(:create)
    end

    context "with valid project data" do
      let(:valid_action) { instance_double CreatesProject, create: true }

      before(:example) do
        allow(CreatesProject).to receive(:new).and_return action
        post :create, project: { name: "Runway", tasks: "Start something:2" }
      end

      it "redirects to projects#index" do
        expect(response).to redirect_to projects_path
      end
    end

    context "with invalid project data" do
      let(:invalid_action) { instance_double CreatesProject, create: false, project: Project.new }

      before(:example) do
        allow(CreatesProject).to receive(:new).and_return invalid_action
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
