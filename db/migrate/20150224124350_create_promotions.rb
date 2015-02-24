class CreatePromotions < ActiveRecord::Migration
  def change
    create_table :promotions do |t|
      t.string :title
      t.datetime :start_at
      t.datetime :end_at
      t.integer :cost
      t.integer :discount_cost
      t.text :store
      t.string :store_url
      t.text :overview
      t.references :category, index: true

      t.timestamps null: false
    end
    add_foreign_key :promotions, :categories
  end
end
