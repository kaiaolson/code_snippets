require 'rails_helper'

RSpec.describe CodeSnippetsController, type: :controller do
  let(:user)           { FactoryGirl.create(:user) }
  let(:code_snippet)   { FactoryGirl.create(:code_snippet, {user: user}) }
  let(:code_snippet_1) { FactoryGirl.create(:code_snippet) }

  describe "#create" do
    context "user signed in" do
      before { login(user) }
      context "with valid attributes" do
        def valid_request
          post :create, code_snippet: FactoryGirl.attributes_for(:code_snippet)
        end
        it "creates a new record in the database" do
          count_before = CodeSnippet.count
          valid_request
          count_after = CodeSnippet.count
          expect(count_after - count_before).to eq(1)
        end
        it "redirects to the code snippet show page" do
          valid_request
          expect(response).to redirect_to(code_snippet_path(CodeSnippet.last))
        end
        it "sets a flash notice message" do
          valid_request
          expect(flash[:notice]).to be
        end
      end
      context "without valid attributes" do
        def invalid_request
          post :create, code_snippet: {title: nil}
        end
        it "does not create a new record in the database" do
          count_before = CodeSnippet.count
          invalid_request
          count_after = CodeSnippet.count
          expect(count_after - count_before).to eq(0)
        end
        it "renders the new template" do
          invalid_request
          expect(response).to render_template(:new)
        end
        it "sets a flash alert message" do
          invalid_request
          expect(flash[:alert]).to be
        end
      end
    end
    context "user not signed in" do
      it "redirects to the login page" do
        post :create, code_snippet: FactoryGirl.attributes_for(:code_snippet)
        expect(response).to redirect_to(new_session_path)
      end
    end
  end

  describe "#destroy" do

    context "user signed in" do
      before { login(user) }
      context "user is owner of the snippet" do
        it "destroys the snippet" do
          code_snippet
          count_before = CodeSnippet.count
          delete :destroy, id: code_snippet
          count_after = CodeSnippet.count
          expect(count_before - count_after).to eq(1)
        end
        it "redirects to the code snippets index page" do
          delete :destroy, id: code_snippet
          expect(response).to redirect_to(code_snippets_path)
        end
        it "sets a flash notice message" do
          delete :destroy, id: code_snippet
          expect(flash[:notice]).to be
        end
      end
      context "user is not the owner of the snippet" do
        it "raises an error" do
          expect do
            delete :destroy, id: code_snippet_1.id
          end.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end

    context "user not signed in" do
      it "redirects to the login page" do
        delete :destroy, id: code_snippet
        expect(response).to redirect_to(new_session_path)
      end
    end
  end
end
