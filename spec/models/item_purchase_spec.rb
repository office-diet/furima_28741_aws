require 'rails_helper'
RSpec.describe ItemPurchase, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item)
    @item.user_id = @user.id
    @item.image = fixture_file_upload('public/images/test.png')
    @item.save
    @purchase = FactoryBot.build(:item_purchase)
    @purchase.user_id = @item.user_id
    @purchase.item_id = @user.id
  end

  describe '商品購入' do
    context '商品購入がうまくいくとき' do
      it '全ての項目が揃っていれば購入できる' do
        expect(@purchase).to be_valid
      end
      it '建物名（building）は空欄でも購入できる' do
        @purchase.building = ''
        expect(@purchase).to be_valid
      end
    end
    context '商品購入が失敗する時' do
      prefecture_count = Prefecture.count
      it 'ログインしていない（ユーザIDが空欄）場合登録できない' do
        @purchase.user_id = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("User can't be blank")
      end
      it 'クレジットカードが不正（token生成失敗）の場合登録できない' do
        @purchase.token = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Token can't be blank")
      end
      it '郵便番号が空欄の場合登録できない' do
        @purchase.postal_code = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Postal code can't be blank")
      end
      it '郵便番号が不正（ハイフンがない）の場合登録できない' do
        @purchase.postal_code = '1234567'
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('Postal code input format 000-0000')
      end
      it '都道府県が空欄の場合登録できない' do
        @purchase.prefecture_id = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '都道府県が未選択の場合登録できない' do
        @purchase.prefecture_id = 0
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('Prefecture You need to select')
      end
      it "都道府県がの選択が不正（#{prefecture_count}以上）の場合登録できない" do
        @purchase.prefecture_id = prefecture_count
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('Prefecture invalid')
      end
      it '市区町村が空欄の場合登録できない' do
        @purchase.town = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Town can't be blank")
      end
      it '番地が空欄の場合登録できない' do
        @purchase.address = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Address can't be blank")
      end
      it '電話番号が空欄の場合登録できない' do
        @purchase.tel = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Tel can't be blank")
      end
      it '電話番号が不正（12桁以上）の場合登録できない' do
        @purchase.tel = '012345678901'
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('Tel numeric only max length 11')
      end
      it '電話番号が不正（ハイフンあり）の場合登録できない' do
        @purchase.tel = '123-1234-1234'
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('Tel numeric only max length 11')
      end
      it '電話番号が不正（全角数字）の場合登録できない' do
        @purchase.tel = '１２３４５６７８９０'
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('Tel numeric only max length 11')
      end
    end
  end
end
