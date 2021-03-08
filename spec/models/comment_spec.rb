require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @user = FactoryBot.build(:user)
    @user.avatar = fixture_file_upload('/files/test_avatar_a.png')
    @user.save
    @photo = FactoryBot.build(:photo)
    @photo.image = fixture_file_upload('/files/test_image.jpg')
    @photo.save
    @comment = FactoryBot.build(:comment, user_id: @user.id, photo_id: @photo.id)

    sleep 0.1
  end

  describe 'コメントの投稿' do
    context 'コメントが投稿できる場合' do
      it '写真およびユーザーが紐付きコメントが記入されていれば投稿できること' do
        expect(@comment).to be_valid
      end
    end

    context 'コメントが投稿できない場合' do
      it 'コメントが記入されていないと投稿できないこと' do
        @comment.text = ''
        @comment.valid?
        expect(@comment.errors.full_messages).to include('Textを入力してください')
      end

      it 'ユーザーおよび写真が紐付いていないと投稿できないこと' do
        @comment.user = nil
        @comment.photo = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('Userを入力してください', 'Photoを入力してください')
      end

      it '写真が紐付いていないと投稿できないこと' do
        @comment.photo = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('Photoを入力してください')
      end

      it 'ユーザーが紐付いていないと投稿できないこと' do
        @comment.user = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('Userを入力してください')
      end
    end
  end
end
