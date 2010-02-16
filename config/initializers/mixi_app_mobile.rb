module ActionView::Helpers::UrlHelper

  def link_to_with_convert_url_for_mixi_app(*args)
    str = link_to_without_convert_url_for_mixi_app(*args)
    if controller.valid_mixi_app_request
      str.match(/href=["']([^'"]+)["']/)
      url = $1
      url = URI.join(root_url, url).to_s unless URI.parse(url).host
      return "#{$`} href=\"?url=#{URI.escape(url)}\"#{$'}"
    else
      return str
    end
  end
  alias_method_chain :link_to, :convert_url_for_mixi_app
end

class ActionController::Base
  def redirect_to_full_url_with_convert_url_for_mixi_app(url, status)
    if valid_mixi_app_request
      logger.debug "convert from #{url}"
      url = "http://ma.mixi.net/#{params[:opensocial_app_id]}/?url=#{URI.escape(url)}"
      logger.debug "convert to #{url}"
    end
    redirect_to_full_url_without_convert_url_for_mixi_app(url, status)
  end
  alias_method_chain :redirect_to_full_url, :convert_url_for_mixi_app
end
