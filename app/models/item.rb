class Item < ApplicationRecord
  has_one :purchase
  has_one :delivery
  belongs_to :user
  has_one_attached :image, dependent: :destroy
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :postage
  belongs_to_active_hash :shipment_delay
  belongs_to_active_hash :prefecture

  with_options presence: true do
    validates :image, :name, :text, :user_id, :price
    validates :price_range_valid?
    validates :category_id, :condition_id, :postage_id, :shipment_delay_id, :prefecture_id, numericality: { other_than: 0, message: 'You need to select' }
    validates :category_id, numericality: { less_than: Category.count, message: 'valid' }
    validates :condition_id, numericality: { less_than: Condition.count, message: 'valid' }
    validates :postage_id, numericality: { less_than: Postage.count, message: 'valid' }
    validates :shipment_delay_id, numericality: { less_than: ShipmentDelay.count, message: 'valid' }
    validates :prefecture_id, numericality: { less_than: Prefecture.count, message: 'valid' }
  end

  private

  def price_range_valid?
    input = price.to_i
    if input < 300 || input > 9_999_999
      errors.add(:price, 'range invalid')
    else
      true
    end
  end
end
