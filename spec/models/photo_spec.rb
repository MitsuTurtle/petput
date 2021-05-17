require 'rails_helper'

RSpec.describe Photo, type: :model do
  before do
    @user = FactoryBot.build(:user)
    @user.avatar = fixture_file_upload('/files/test_avatar_a.png')
    @user.save
    @photo = FactoryBot.build(:photo, user_id: @user.id)
    @photo.image = fixture_file_upload('/files/test_image.jpg')

    sleep 0.1
  end

  describe '写真の投稿' do
    context '写真の投稿がうまくいく場合' do
      it 'すべての要素が正しく入力されていると投稿できること' do
        expect(@photo).to be_valid
      end
    end

    context '写真の投稿がうまくいかない場合' do
      it '画像ファイルが未選択だと投稿できないこと' do
        @photo.image = nil
        @photo.valid?
        expect(@photo.errors.full_messages).to include('ペット写真を選択してください')
      end
      it 'キャプションが未入力だと投稿できないこと' do
        @photo.caption = ''
        @photo.valid?
        expect(@photo.errors.full_messages).to include('写真の説明を入力してください')
      end
      it 'カテゴリーが未選択だと出品できないこと' do
        @photo.category_id = 0
        @photo.valid?
        expect(@photo.errors.full_messages).to include('カテゴリーを選択してください')
      end
      it 'ユーザーが紐付いていなければ投稿できないこと' do
        @photo.user = nil
        @photo.valid?
        expect(@photo.errors.full_messages).to include('Userを入力してください')
      end
    end
  end
end
