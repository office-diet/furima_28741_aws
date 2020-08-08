require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it '全ての項目が揃っていれば登録できる' do
        expect(@user).to be_valid
      end
      it 'passwordが英数混合・6文字以上であれば登録できる' do
        password = 'a1b2c3d'
        @user.password = password
        @user.password_confirmation = password
        expect(@user).to be_valid
      end
    end
    context '新規登録がうまくいかないとき' do
      it 'nicknameが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '重複したemailが存在する場合登録できない' do
        @user.save
        user2 = FactoryBot.build(:user)
        user2.email = @user.email
        user2.valid?
        expect(user2.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailアドレスに@を含まない場合登録できない' do
        @user.email = @user.email.gsub!('@', '')
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが半角数字だけでは登録できない' do
        @user.password = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password input half-width numbers and characters.')
      end
      it 'passwordが半角英字だけでは登録できない' do
        @user.password = 'AbCdEf'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password input half-width numbers and characters.')
      end
      it 'passwordが5文字以下であれば登録できない' do
        @user.password = 'a1b2c'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it '苗字が空では登録できない' do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank")
      end
      it '苗字が半角英数字の場合登録できない' do
        @user.family_name = 'Yamada1'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name input full-width japanese characters.')
      end
      it '苗字が半角文字の場合登録できない' do
        @user.family_name = 'ﾔﾏﾀﾞ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name input full-width japanese characters.')
      end
      it '苗字が全角英数字の場合登録できない' do
        @user.family_name = 'ＡＡＡＡ１'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name input full-width japanese characters.')
      end
      it '名前が空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it '名前が半角英数字の場合登録できない' do
        @user.first_name = 'Yamada1'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name input full-width japanese characters.')
      end
      it '名前が半角文字の場合登録できない' do
        @user.first_name = 'ﾔﾏﾀﾞ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name input full-width japanese characters.')
      end
      it '名前が全角英数字の場合登録できない' do
        @user.first_name = 'ＡＡＡＡ１'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name input full-width japanese characters.')
      end
      it '苗字（カナ）が空では登録できない' do
        @user.family_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana can't be blank")
      end
      it '苗字（カナ）が半角英数字の場合登録できない' do
        @user.family_name_kana = 'Yamada1'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name kana input full-width katakana characters.')
      end
      it '苗字（カナ）が半角文字の場合登録できない' do
        @user.family_name_kana = 'ﾔﾏﾀﾞ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name kana input full-width katakana characters.')
      end
      it '苗字（カナ）が全角英数字の場合登録できない' do
        @user.family_name_kana = 'ＡＡＡＡ１'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name kana input full-width katakana characters.')
      end
      it '名前（カナ）が空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it '名前（カナ）が半角英数字の場合登録できない' do
        @user.first_name_kana = 'Yamada1'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana input full-width katakana characters.')
      end
      it '名前（カナ）が半角文字の場合登録できない' do
        @user.first_name_kana = 'ﾔﾏﾀﾞ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana input full-width katakana characters.')
      end
      it '名前（カナ）が全角英数字の場合登録できない' do
        @user.first_name_kana = 'ＡＡＡＡ１'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana input full-width katakana characters.')
      end
      it '生年月日が空だと登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
