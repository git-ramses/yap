# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { instance_double(::User) }

  describe '#index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe '#show' do
    before { allow(::User).to receive(:find).and_return(user) }

    it 'renders the show template' do
      get :show, params: { id: 1 }
      expect(response).to render_template(:show)
    end
  end

  describe '#edit' do
    before { allow(::User).to receive(:find).and_return(user) }

    it 'renders the edit template' do
      get :edit, params: { id: 1 }
      expect(response).to render_template(:edit)
    end
  end

  describe '#update' do
    let(:params) do
      {
        id: 1,
        user: {
          email: 'test1@fake.com',
          role: 'member',
          team: '1'
        }
      }
    end
    before { allow(::User).to receive(:find).and_return(user) }

    context 'when update fails' do
      before do
        allow(user).to receive(:update).and_return(false)
        allow(user).to receive_message_chain(:errors, :full_messages, :join).and_return('Some Error')
      end

      it 'flashes an error and redirects to the edit path' do
        patch :update, params: params

        expect(response).to redirect_to(edit_user_path(user))
        expect(flash[:danger]).to eq('Some Error')
      end
    end

    context 'when update succeeds' do
      before { allow(user).to receive(:update).and_return(true) }

      it 'updates the user and redirects to user path' do
        patch :update, params: params

        expect(response).to redirect_to(user_path(user))
        expect(flash[:success]).to eq('User updated successfully')
      end
    end
  end
end
