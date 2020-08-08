class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string   :name,            null: false
      t.text     :text,            null: false
      t.integer  :price,           null: false
      t.bigint   :user_id,            null: false, foreign_key: true
      t.integer  :category_id,        null: false, foreign_key: true
      t.integer  :condition_id,       null: false, foreign_key: true
      t.integer  :postage_id,         null: false, foreign_key: true
      t.integer  :prefecture_id,       null: false, foreign_key: true
      t.integer  :shipment_delay_id,  null: false, foreign_key: true

      t.timestamps
    end
  end
end
