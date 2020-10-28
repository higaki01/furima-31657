require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @form = FactoryBot.build(:form)
  end

  # 正常系 初期値にバリデーションに整合する固定値をセットして保存確認
  # 異常系 各々バリデーションについて保存確認

  describe '商品購入機能' do
    context '商品購入が成功する場合' do
      it '全入力情報が正しく入力されていること' do
        expect(@form).to be_valid
      end
    end

    context '商品購入が失敗する場合' do
      it '郵便番号が空であること' do
        @form.postal_code = ''
        @form.valid?
        expect(@form.errors.full_messages).to include("Postal code can't be blank")
      end
      it '郵便番号はハイフンを含む正しい形式でないと保存できないこと' do
        @form.postal_code = '1234567'
        @form.valid?
        expect(@form.errors.full_messages).to include('Postal code Input correctly')
      end
      it '都道府県が選択されていないこと' do
        @form.prefecture_id = 1
        @form.valid?
        expect(@form.errors.full_messages).to include('Prefecture Select')
      end
      it '市区町村が空であること' do
        @form.city = ''
        @form.valid?
        expect(@form.errors.full_messages).to include("City can't be blank")
      end
      it '番地が空であること' do
        @form.address = ''
        @form.valid?
        expect(@form.errors.full_messages).to include("Address can't be blank")
      end
      it '電話番号が空であること' do
        @form.phone = ''
        @form.valid?
        expect(@form.errors.full_messages).to include("Phone can't be blank")
      end
      it '電話番号はハイフン不要で11桁以下でないと保存できないこと' do
        @form.phone = '090-1234-5678'
        @form.valid?
        expect(@form.errors.full_messages).to include('Phone Input only number')
      end
      it 'トークンが空であること' do
        @form.token = ''
        @form.valid?
        expect(@form.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
