class PagesController < ApplicationController
  def index
  	@categories = Category.all
    @promotions = Promotion.all
  end
end