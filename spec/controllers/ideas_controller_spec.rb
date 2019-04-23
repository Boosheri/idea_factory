require 'rails_helper'

RSpec.describe IdeasController, type: :controller do

    def current_user
        @current_user ||= FactoryBot.create(:user)
    end
    
    describe "#new" do
        context "without signed in user" do

            it "redirects the user to session new" do
                get(:new)
                expect(response).to redirect_to(new_session_path)
            end

        end
        
        context "with signed in user" do
            before do
                session[:user_id] = current_user.id
            end
            
            it "renders a new template" do
                get(:new)
                expect(response).to(render_template(:new))
            end
        end
    end

    describe "#create" do
    
        def valid_idea
            post(:create, params: { idea: FactoryBot.attributes_for(:idea) })
        end
        
        def saved_idea
            post(:create, params: { idea: FactoryBot.create(:idea) })
        end

        context "without signed in user" do
            it "redirects to the new session path" do
                valid_idea
                expect(response).to redirect_to(new_session_path)
            end
        end
    
        context "with signed in user" do

            before do
                session[:user_id] = current_user.id
            end

            it "renders a new template" do
                get(:new)
                expect(response).to(render_template(:new))
            end
            
            it "sets an instance variable of a new idea" do
                get(:new)
                expect(assigns(:idea)).to(be_a_new(Idea))
            end

            context "with invalid parameters" do
                it "doesn't create a job post" do
                    count_before = Idea.count
                    idea = Idea.create
                    count_after = Idea.count
                    expect(count_after).to(eq(count_before))
                end
            end
        end
    end
    
end