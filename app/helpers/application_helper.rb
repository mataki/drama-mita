# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def have_wathed?
    return @result unless @result.nil?
    @result = (current_user.watches.count > 0)
  end
end
