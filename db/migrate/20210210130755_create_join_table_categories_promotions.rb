class CreateJoinTableCategoriesPromotions < ActiveRecord::Migration[6.1]
  def change
    create_join_table :categories, :promotions do |t|
      # t.index [:category_id, :promotion_id]
      # t.index [:promotion_id, :category_id]
    end
  end
end
