class InfoController < ApplicationController
  skip_before_filter :require_user, :only => :welcome

  def welcome
    @current_user = current_user || User.create_by_mixi_id!(params[:opensocial_owner_id])
  end
end
