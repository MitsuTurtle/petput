require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user_a = FactoryBot.build(:user)
    @user_b = FactoryBot.create(:user)
  end

  describe '新規登録' do
    context '新規登録できる場合' do
      it 'すべての要素が正しく入力されていると登録できる' do
        expect(@user_a).to be_valid
      end
    end

    context '新規登録できない場合' do
      it 'ニックネームが未入力だと登録できない' do
        @user_a.nickname = ''
        @user_a.valid?
        expect(@user_a.errors.full_messages).to include("Nickname can't be blank")
      end
      it '既登録のニックネームだと登録できない' do
        @user_a.nickname = @user_b.nickname
        @user_a.valid?
        expect(@user_a.errors.full_messages).to include('Nickname has already been taken')
      end
      it 'メールアドレスが未入力だと登録できない' do
        @user_a.email = ''
        @user_a.valid?
        expect(@user_a.errors.full_messages).to include("Email can't be blank")
      end
      it '既登録のメールアドレスだと登録できない' do
        @user_a.email = @user_b.email
        @user_a.valid?
        expect(@user_a.errors.full_messages).to include('Email has already been taken')
      end
      it 'メールアドレスに@が含まれていないと登録できない' do
        @user_a.email = 'test55gmail.com'
        @user_a.valid?
        expect(@user_a.errors.full_messages).to include('Email is invalid')
      end
      it 'パスワードが未入力だと登録できない' do
        @user_a.password = ''
        @user_a.valid?
        expect(@user_a.errors.full_messages).to include("Password can't be blank")
      end
      it 'パスワードが5文字以下だと登録できない' do
        @user_a.password = '1111a'
        @user_a.password_confirmation = @user_a.password
        @user_a.valid?
        expect(@user_a.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'パスワードが半角英字のみだと登録できない' do
        @user_a.password = 'aaaaaa'
        @user_a.password_confirmation = @user_a.password
        @user_a.valid?
        expect(@user_a.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end
      it 'パスワードが半角数字のみだと登録できない' do
        @user_a.password = '111111'
        @user_a.password_confirmation = @user_a.password
        @user_a.valid?
        expect(@user_a.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end
      it 'パスワードに全角英字が含まれると登録できない' do
        @user_a.password = 'Ａ1111a'
        @user_a.password_confirmation = @user_a.password
        @user_a.valid?
        expect(@user_a.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end
      it 'パスワードに全角数字が含まれると登録できない' do
        @user_a.password = '１1111a'
        @user_a.password_confirmation = @user_a.password
        @user_a.valid?
        expect(@user_a.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end
      it '確認用パスワードが未入力だと登録できない' do
        @user_a.password_confirmation = ''
        @user_a.valid?
        expect(@user_a.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'パスワードと確認用パスワードが不一致だと登録できない' do
        @user_a.password_confirmation = "#{Faker::Internet.password(min_length: 5)}1a"
        @user_a.valid?
        expect(@user_a.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end
  end
end
