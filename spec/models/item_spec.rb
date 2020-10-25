require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item) # 初期値にバリデーションに整合する固定値を設定
  end

  # 正常系 初期値に登録可能な固定値をセットして保存確認後、
  #       各々の項目で明示的に値を変更して保存を確認する
  # 異常系 各々バリデーションについて保存確認する

  describe '商品出品機能' do
    context '商品登録が成功する場合' do
      it '全入力情報が存在すること' do
        expect(@item).to be_valid
      end
      it '販売価格が半角数字であること' do
        @item.price = 2000
        expect(@item).to be_valid
      end
    end

    context '商品登録が失敗する場合' do
      it '商品画像が空であること' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名が空であること' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it '商品説明が空であること' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it 'カテゴリーが選択されていないこと' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Category Select')
      end
      it '商品状態が選択されていないこと' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Condition Select')
      end
      it '配送料負担が選択されていないこと' do
        @item.shipping_cost_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping cost Select')
      end
      it '発送元地域が選択されていないこと' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture Select')
      end
      it '発送までの日数が選択されていないこと' do
        @item.shipping_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping day Select')
      end
      it '販売価格が空であること' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it '販売価格が 300円未満であること' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Out of setting range')
      end
      it '販売価格が 10,000,000円以上であること' do
        @item.price = 10**7
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Out of setting range')
      end
      it '販売価格が半角数字以外であること' do
        @item.price = '１００００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
    end
  end
end
