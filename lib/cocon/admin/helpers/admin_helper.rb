module AdminHelper
  def active_menu(controller, action=nil)
    if action
      'active' if controller.include?(params[:controller]) && action == params[:action]
    else
      'active' if controller.include?(params[:controller])
    end
  end
end