require 'rails_helper'

RSpec.describe AuthenticationsController, type: :controller do
  let(:user) { create :user }

  shared_examples 'redirect_to_root' do
    it 'redirects to root path' do
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'get new' do
    context 'when user is not logged in' do
      before(:each) { get :new }

      it 'renders view "new"' do
        expect(response).to render_template(:new)
      end
    end

    context 'when user is logged in' do
      before :each do
        allow(controller).to receive(:current_user).and_return(user)
        get :new
      end

      it_behaves_like 'redirect_to_root'
    end
  end

  describe 'post create' do
    context 'when user is not logged in' do
      context 'for valid credentials' do
        before(:each) { post :create, login: user.login, password: 'secret' }

        it_behaves_like 'redirect_to_root'

        it 'sets user_id in session' do
          expect(session[:user_id]).to eq(user.id)
        end
      end

      context 'for invalid credentials' do
        before(:each) { post :create, login: user.login, password: 'nope' }

        it 'does not set user_id in session' do
          expect(session[:user_id]).to be_nil
        end

        it 'renders view "new"' do
          expect(response).to render_template(:new)
        end
      end
    end

    context 'when user is logged in' do
      before :each do
        allow(controller).to receive(:current_user).and_return(user)
        post :create, { login: 'a', password: 'b' }
      end

      it_behaves_like 'redirect_to_root'
    end
  end

  describe 'delete destroy' do
    before(:each) { delete :destroy }

    it_behaves_like 'redirect_to_root'

    it 'removes user_id from session' do
      expect(session[:user_id]).to be_nil
    end
  end
end
