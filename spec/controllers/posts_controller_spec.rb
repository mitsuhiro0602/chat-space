require 'rails_helper'

describe PostsController do
  let(:group) {create(:group)}
  let(:user) {create(:user)}

  describe '#index' do
    context 'log in' do
      before do
        login user
        get :index, params: { group_id: group.id}
      end

      it 'assigns @post' do
        expect(assigns(:post)).to be_a_new(Post)
      end

      it 'assigns @group' do
        expect(assigns(:group)).to eq group
      end

      it 'renders index' do
        expect(response).to render_template :index
      end
    end

    context 'not log in' do
      before do
        get :index, params: {group_id: group.id}
      end

      it 'redirects to new_user_sessinon_path' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe '#create' do
    let(:params) { { group_id: group.id, user_id: user.id, post: attributes_for(:post)}}

    context 'log in' do
      before do
        login user
      end

      context 'can save' do
        subject {
          post :create,
          params: params
        }

        it 'count up post' do
          expect{ subject }.to change(Post, :count).by(1)
        end

        it 'redirects to group_posts_path' do
          subject
          expect(response).to redirect_to(group_posts_path(group))
      end
    end

    context 'can not save' do
      let(:invalid_params) {{ group_id: group.id, user_id: user.id, post: attributes_for(:post, text: nil, image: nil)}}

      subject {
        post :create,
        params: invalid_params
      }

      it 'does not count up' do
        expect{ subject }.not_to change(Post, :count)
      end

      it 'renders index' do
        subject
        expect(response).to render_template :index
      end
    end
  end

  context 'not log in' do
    it 'redirects to new_user_session_path' do
      post :create, params: params
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
end
