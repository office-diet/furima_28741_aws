require 'rails_helper'
RSpec.describe Item, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item)
    @item.user_id = @user.id
    @item.image = fixture_file_upload('public/images/test.png')
  end

  describe 'ユーザー新規登録' do
    context '商品登録がうまくいくとき' do
      it '全ての項目が揃っていれば登録できる' do
        expect(@item).to be_valid
      end
    end
    context '商品登録がうまくいかないとき' do
      category_count = Category.count
      condition_count = Condition.count
      postage_count = Postage.count
      prefecture_count = Prefecture.count
      shipment_delay_count = ShipmentDelay.count
      it 'ログインしていない（ユーザIDが空欄）場合登録できない' do
        @item.user_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("User can't be blank")
      end
      it '商品名が未入力の場合は登録できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it '商品説明が未入力の場合は登録できない' do
        @item.text = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Text can't be blank")
      end
      it 'カテゴリーが空欄の場合は登録できない' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it 'カテゴリーが未選択（値：0）の場合は登録できない' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Category You need to select')
      end
      it "カテゴリーが不正な値（#{category_count}以上）の場合は登録できない" do
        @item.category_id = category_count
        @item.valid?
        expect(@item.errors.full_messages).to include('Category valid')
      end
      it '商品の状態が空欄の場合は登録できない' do
        @item.condition_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end
      it '商品の状態が未選択（値：0）の場合は登録できない' do
        @item.condition_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Condition You need to select')
      end
      it "商品の状態が不正な値（#{condition_count}以上）の場合は登録できない" do
        @item.condition_id = category_count
        @item.valid?
        expect(@item.errors.full_messages).to include('Condition valid')
      end
      it '発送料の負担が空欄の場合は登録できない' do
        @item.postage_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Postage can't be blank")
      end
      it '発送料の負担が未選択（値：0）の場合は登録できない' do
        @item.postage_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Postage You need to select')
      end
      it "発送料の負担が不正な値（#{postage_count}以上）の場合は登録できない" do
        @item.postage_id = postage_count
        @item.valid?
        expect(@item.errors.full_messages).to include('Postage valid')
      end
      it '発送までの日数が空欄の場合は登録できない' do
        @item.shipment_delay_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipment delay can't be blank")
      end
      it '発送までの日数が未選択（値：0）の場合は登録できない' do
        @item.shipment_delay_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipment delay You need to select')
      end
      it "発送までの日数が不正な値（#{shipment_delay_count}以上）の場合は登録できない" do
        @item.shipment_delay_id = shipment_delay_count
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipment delay valid')
      end
      it '発送元の地域が空欄の場合は登録できない' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '発送元の地域が未選択（値：0）の場合は登録できない' do
        @item.prefecture_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture You need to select')
      end
      it "発送元の地域が未選択（#{prefecture_count}以上）の場合は登録できない" do
        @item.prefecture_id = prefecture_count
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture valid')
      end
      it '価格が未入力の場合は登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it '価格が300未満の場合は登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price range invalid')
      end
      it '価格が9,999,999超過の場合は登録できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price range invalid')
      end
    end
  end
end
