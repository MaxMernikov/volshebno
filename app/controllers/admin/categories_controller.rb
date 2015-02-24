class Admin::CategoriesController < Admin::BaseController
  def create
    create!{ collection_url }
  end

  def update
    update!{ collection_url }
  end

private
  def category_params
    params.require(:category).permit(:title)
  end

  def collection
    get_collection_ivar || Category.order(:created_at)
  end
end