require 'rails_helper'

RSpec.describe Photo, type: :model do
  before do
    @photo = FactoryBot.build(:photo)
    @photo.image = fixture_file_upload('/files/test_image.png')
  end

  describe '写真の投稿' do
    context '写真の投稿がうまくいくとき' do
      it 'すべての要素が正しく入力されていると投稿できる' do
        expect(@photo).to be_valid
      end
    end

    context '写真の投稿がうまくいかないとき' do
      it '画像ファイルが未選択だと投稿できない' do
        @photo.image = nil
        @photo.valid?
        expect(@photo.errors.full_messages).to include("Image can't be blank")
      end
      it 'キャプションが未入力だと投稿できない' do
        @photo.caption = ''
        @photo.valid?
        expect(@photo.errors.full_messages).to include("Caption can't be blank")
      end
      it 'カテゴリーが未選択だと出品できない' do
        @photo.category_id = 0
        @photo.valid?
        expect(@photo.errors.full_messages).to include('Category must be other than 0')
      end
    end
  end
end
