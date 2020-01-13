require 'rails_helper'

RSpec.describe Post, type: :model do
  describe '#create' do
    context 'can save' do
      it 'is valid with text' do
        expect(build(:post, image: nil)).to be_valid
      end

      it 'is valid with image' do
        expect(build(:post, text: nil)).to be_valid
      end

      it 'is valid with text and image' do
        expect(build(:post)).to be_valid
      end
    end

    context 'can not save' do
      it 'is invalid withot text and image' do
        post = build(:post, text: nil, image: nil)
        post.valid?
        expect(post.errors[:text]).to include('を入力してください')
      end

      it 'is invalid without group_id' do
        post = build(:post, group_id: nil)
        post.valid?
        expect(post.errors[:group]).to include('を入力してください')
      end

      it 'is invalid without user_id' do
        post = build(:post, user_id: nil)
        post.valid?
        expect(post.errors[:user]).to include('を入力してください')
      end
    end

  end
end
