require "rails_helper"

RSpec.describe StaticPagesController, type: :controller do
  describe "GET home" do
    let!(:soccer_match1) { create(:soccer_match) }
    context "finds specific soccer match" do
      before { get :home, params: {teams_cont: "Arsenal"}}
      it "should find soccer match by team name" do
        expect(assigns(:soccer_matches).first).to eq soccer_match1
      end

      it { should respond_with(:success) }
      it { should render_template(:home) }
    end
  end
  describe "GET help" do
    it "render help" do
      get :help
      expect(response).to render_template(:help)
    end
  end
  describe "GET about" do
    it "render about" do
      get :about
      expect(response).to render_template(:about)
    end
  end
end
