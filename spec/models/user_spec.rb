require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'User' do
    before do
      @user = FactoryBot.build(:user) # 初期値にバリデーションに整合する固定値を設定
    end

    # 正常系 初期値に登録可能な固定値をセットして保存確認後、
    #       各々の項目で明示的に値を変更して保存を確認する
    # 異常系 各々バリデーションについて保存確認する

    describe 'ユーザー新規登録' do
      context '新規登録が成功する場合' do
        it '全入力情報が存在すること' do
          expect(@user).to be_valid
        end
        it 'メールアドレスに重複がないこと' do
          @user.save
          user2 = FactoryBot.build(:user)
          user2.email = 'a@a.com'
          expect(user2).to be_valid
        end
        it 'メールアドレスに@が含まれること' do
          @user.email = 'b@ab.com'
          expect(@user).to be_valid
        end
        it 'パスワードが6文字以上であること' do
          @user.password = '12345a'
          @user.password_confirmation = '12345a'
          expect(@user).to be_valid
        end
        it 'パスワードが半角英数字混合であること' do
          @user.password = '123abc'
          @user.password_confirmation = '123abc'
          expect(@user).to be_valid
        end
        it 'パスワードと確認用パスワードが一致すること' do
          @user.password_confirmation = @user.password
          expect(@user).to be_valid
        end
        it 'ユーザー本名（名字）が全角（漢字・ひらがな・カタカナ）であること' do
          @user.familyname = '田中'
          expect(@user).to be_valid
        end
        it 'ユーザー本名（名前）が全角（漢字・ひらがな・カタカナ）であること' do
          @user.firstname = '太郎'
          expect(@user).to be_valid
        end
        it 'ユーザー本名（名字）のフリガナが全角（カタカナ）であること' do
          @user.familyname_kana = 'タナカ'
          expect(@user).to be_valid
        end
        it 'ユーザー本名（名前）のフリガナが全角（カタカナ）であること' do
          @user.familyname_kana = 'タロウ'
          expect(@user).to be_valid
        end
      end

      context '新規登録が失敗する場合' do
        it 'ニックネームが空であること' do
          @user.nickname = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Nickname can't be blank")
        end
        it 'メールアドレスが空であること' do
          @user.email = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Email can't be blank")
        end
        it 'メールアドレスが重複していること' do
          @user.save
          user2 = FactoryBot.build(:user)
          user2.email = @user.email
          user2.valid?
          expect(user2.errors.full_messages).to include('Email has already been taken')
        end
        it 'メールアドレスに@が含まれないこと' do
          @user.email = 'aaa'
          @user.valid?
          expect(@user.errors.full_messages).to include('Email is invalid')
        end
        it 'パスワードが空であること' do
          @user.password = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Password can't be blank")
        end
        it 'パスワードが５文字以下であること' do
          @user.password = '1234a'
          @user.password_confirmation = '1234a'
          @user.valid?
          expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
        end
        it 'パスワードが半角英数字混合でないこと' do
          @user.password = '123456'
          @user.password_confirmation = '123456'
          @user.valid?
          expect(@user.errors.full_messages).to include('Password 英字と数字の両方を含めて設定してください')
        end
        it 'パスワードと確認用パスワードが一致しないこと' do
          @user.password = '12345a'
          @user.password_confirmation = '12345b'
          @user.valid?
          expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
        end
        it 'ユーザー名（名字）が空であること' do
          @user.familyname = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Familyname can't be blank")
        end
        it 'ユーザー名（名字）に全角（漢字・ひらがな・カタカナ）以外が含まれること' do
          @user.familyname = 'Suzuki'
          @user.valid?
          expect(@user.errors.full_messages).to include('Familyname 全角文字を使用してください')
        end
        it 'ユーザー名（名前）が空であること' do
          @user.firstname = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Firstname can't be blank")
        end
        it 'ユーザー名（名前）に全角（漢字・ひらがな・カタカナ）以外が含まれること' do
          @user.firstname = 'ichiro'
          @user.valid?
          expect(@user.errors.full_messages).to include('Firstname 全角文字を使用してください')
        end
        it 'ユーザー名（名字）のフリガナが空であること' do
          @user.familyname_kana = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Familyname kana can't be blank")
        end
        it 'ユーザー名（名字）のフリガナが全角（カタカナ）以外が含まれること' do
          @user.familyname_kana = 'すずき'
          @user.valid?
          expect(@user.errors.full_messages).to include('Familyname kana 全角カタカナを使用してください')
        end
        it 'ユーザー名（名前）のフリガナが空であること' do
          @user.firstname_kana = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Firstname kana can't be blank")
        end
        it 'ユーザー名（名前）のフリガナが全角（カタカナ）以外が含まれること' do
          @user.firstname_kana = 'いちろう'
          @user.valid?
          expect(@user.errors.full_messages).to include('Firstname kana 全角カタカナを使用してください')
        end
        it '生年月日か空であること' do
          @user.birth_date = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Birth date can't be blank")
        end
      end
    end
  end
end
