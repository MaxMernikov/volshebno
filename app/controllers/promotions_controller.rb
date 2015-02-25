class PromotionsController < ApplicationController
  before_action :init_resource

  def show
    render json: @resource
  end

  private

  def init_resource
    @resource = Promotion.find(params[:id])
  end
end