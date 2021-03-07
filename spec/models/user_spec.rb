require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user_a = FactoryBot.build(:user)
    @user_a.avatar = fixture_file_upload('/files/test_avatar_a.png')

    @user_b = FactoryBot.build(:user)
    @user_b.avatar = fixture_file_upload('/files/test_avatar_b.jpg')
    @user_b.save

    sleep 0.1
  end

  describe '新規登録' do
    context '新規登録できる場合' do
      it 'すべての要素が正しく入力されていると登録できること' do
        expect(@user_a).to be_valid
      end

      it 'profileは空白でも登録できること' do
        @user_a.profile = ''
        expect(@user_a).to be_valid
      end

      it 'ニックネームが4文字だと登録できること' do
        @user_a.nickname = Faker::Name.initials(number: 4)
        expect(@user_a).to be_valid
      end
      
      it 'ニックネームが15文字だと登録できること' do
        @user_a.nickname = Faker::Name.initials(number: 15)
        expect(@user_a).to be_valid
      end
    end

    context '新規登録できない場合' do
      it 'ニックネームが未入力だと登録できないこと' do
        @user_a.nickname = ''
        @user_a.valid?
        expect(@user_a.errors.full_messages).to include('ユーザーネームを入力してください')
      end

      it 'ニックネームが3文字だと登録できないこと' do
        @user_a.nickname = Faker::Name.initials(number: 3)
        @user_a.valid?
        expect(@user_a.errors.full_messages).to include('ユーザーネームは4文字以上で入力してください')
      end
      
      it 'ニックネームが16文字だと登録できないこと' do
        @user_a.nickname = Faker::Name.initials(number: 16)
        @user_a.valid?
        expect(@user_a.errors.full_messages).to include('ユーザーネームは15文字以内で入力してください')
      end

      it '既登録のニックネームだと登録できないこと' do
        @user_a.nickname = @user_b.nickname
        @user_a.valid?
        expect(@user_a.errors.full_messages).to include('ユーザーネームはすでに存在します')
      end

      it 'プロフィール画像が未選択だと登録できないこと' do
        @user_a.avatar = nil
        @user_a.valid?
        expect(@user_a.errors.full_messages).to include('プロフィール画像を選択してください')
      end

      it 'メールアドレスが未入力だと登録できないこと' do
        @user_a.email = ''
        @user_a.valid?
        expect(@user_a.errors.full_messages).to include('メールアドレスを入力してください')
      end

      it '既登録のメールアドレスだと登録できないこと' do
        @user_a.email = @user_b.email
        @user_a.valid?
        expect(@user_a.errors.full_messages).to include('メールアドレスはすでに存在します')
      end

      it 'メールアドレスに@が含まれていないと登録できないこと' do
        @user_a.email = 'test55gmail.com'
        @user_a.valid?
        expect(@user_a.errors.full_messages).to include('メールアドレスは不正な値です')
      end

      it 'パスワードと確認用パスワードが不一致だと登録できないこと' do
        @user_a.password = Faker::Lorem.characters(number: rand(6..128), min_alpha: 1, min_numeric: 1).to_s
        @user_a.valid?
        expect(@user_a.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
      end

      it 'パスワードが未入力だと登録できないこと' do
        @user_a.password = ''
        @user_a.valid?
        expect(@user_a.errors.full_messages).to include('パスワードを入力してください')
      end

      it '確認用パスワードが未入力だと登録できないこと' do
        @user_a.password_confirmation = ''
        @user_a.valid?
        expect(@user_a.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
      end

      it 'パスワードが5文字だと登録できないこと' do
        @user_a.password = Faker::Lorem.characters(number: 5, min_alpha: 1, min_numeric: 1).to_s
        @user_a.password_confirmation = @user_a.password
        @user_a.valid?
        expect(@user_a.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end

      it 'パスワードが英半角数字混合でも5文字以下だと登録できないこと' do
        @user_a.password = Faker::Lorem.characters(number: rand(2..5), min_alpha: 1, min_numeric: 1).to_s
        @user_a.password_confirmation = @user_a.password
        @user_a.valid?
        expect(@user_a.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end

      it 'パスワードが129文字だと登録できないこと' do
        @user_a.password = Faker::Lorem.characters(number: 129, min_alpha: 1, min_numeric: 1).to_s
        @user_a.password_confirmation = @user_a.password
        @user_a.valid?
        expect(@user_a.errors.full_messages).to include('パスワードは128文字以内で入力してください')
      end

      it 'パスワードが129文字以上だと登録できないこと' do
        @user_a.password = Faker::Lorem.characters(number: rand(129..500), min_alpha: 1, min_numeric: 1).to_s
        @user_a.password_confirmation = @user_a.password
        @user_a.valid?
        expect(@user_a.errors.full_messages).to include('パスワードは128文字以内で入力してください')
      end

      it 'パスワードが半角英字のみだと登録できないこと' do
        alphabets_array = ('a'..'z').to_a + ('A'..'Z').to_a
        @user_a.password = rand(6..128).times.map { alphabets_array.sample }.join
        @user_a.password_confirmation = @user_a.password
        @user_a.valid?
        expect(@user_a.errors.full_messages).to include('パスワードは半角英数字混合で入力してください')
      end

      it 'パスワードが半角数字のみだと登録できないこと' do
        nums_array = (0..9).to_a
        @user_a.password = rand(6..128).times.map { nums_array.sample }.join
        @user_a.password_confirmation = @user_a.password
        @user_a.valid?
        expect(@user_a.errors.full_messages).to include('パスワードは半角英数字混合で入力してください')
      end

      it 'パスワードに全角英字が含まれると登録できない' do
        @user_a.password = 'Ａ1234a'
        @user_a.password_confirmation = @user_a.password
        @user_a.valid?
        expect(@user_a.errors.full_messages).to include('パスワードは半角英数字混合で入力してください')
      end

      it 'パスワードに全角数字が含まれると登録できない' do
        @user_a.password = '１abcd1'
        @user_a.password_confirmation = @user_a.password
        @user_a.valid?
        expect(@user_a.errors.full_messages).to include('パスワードは半角英数字混合で入力してください')
      end
    end
  end
end
