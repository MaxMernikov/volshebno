class Admin::PromotionsController < Admin::BaseController
  def create
    create!{ collection_url }
  end

  def update
    update!{ collection_url }
  end

private
  def promotion_params
    params.require(:promotion).permit(:title, :start_at, :end_at, :cost, :discount_cost, :store, :store_url, :overview, :category_id, :image )
  end

  def collection
    get_collection_ivar || Promotion.order(:created_at)
  end
end