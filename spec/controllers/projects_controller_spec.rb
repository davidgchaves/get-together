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
end
