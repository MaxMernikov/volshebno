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

      t.string :image_file_name
      t.integer :image_file_size
      t.string :image_content_type
      t.datetime :image_updated_at

      t.timestamps null: false
    end
    add_foreign_key :promotions, :categories
  end
end
