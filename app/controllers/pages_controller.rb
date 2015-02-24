class PagesController < ApplicationController
  def index
    @promotions = Promotion.all
  end
end