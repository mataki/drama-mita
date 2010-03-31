require "oauth"
require 'oauth/request_proxy/action_controller_request'

module ActionView::Helpers::UrlHelper
  def link_to_with_convert_url_for_mixi_app(*args)
    str = link_to_without_convert_url_for_mixi_app(*args)
    if controller.valid_mixi_app_request
      str.match(/href=["']([^'"]+)["']/)
      url = $1
      url = URI.join(root_url, url).to_s unless URI.parse(url).host
      return "#{$`} href=\"?guid=ON&url=#{URI.escape(url)}\"#{$'}"
    else
      return str
    end
  end
  alias_method_chain :link_to, :convert_url_for_mixi_app
end

module ActionView::Helpers::FormTagHelper

private
  def html_options_for_form_with_convert_url_for_mixi_app(*args)
    result = html_options_for_form_without_convert_url_for_mixi_app(*args)
    if controller.valid_mixi_app_request
      url = result["action"]
      logger.info "convert from #{url}"
      url = URI.join(root_url, url).to_s unless URI.parse(url).host
      logger.info "convert to #{url}"
      result["action"] = "?guid=ON&url=#{URI.escape(url)}"
    end
    result
  end
  alias_method_chain :html_options_for_form, :convert_url_for_mixi_app
end

module OAuth::RequestProxy
  class ActionControllerRequestForMixi < ActionControllerRequest
    MIXI_PARAMETERS = OAuth::PARAMETERS + %w(opensocial_app_id opensocial_owner_id)
    def parameters_for_signature
      result = super
      result.select{ |k,v| MIXI_PARAMETERS.include?(k) }
    end
  end
end

module MixiAppMobileController
  @@reject_invalid_access_enviroments = %w(production staging)

  def self.included(klass)
    klass.class_eval do
      before_filter :valid_mixi_app_mobile_request?
      helper_method :convert_url_for_mixi_app
      alias_method_chain :redirect_to_full_url, :convert_url_for_mixi_app

      # TODO: テスト様にどのように処理を分離するとよいか検討
      attr_reader :valid_mixi_app_request

      def self.reject_invalid_access?
        @@reject_invalid_access_enviroments.include?(::Rails.env)
      end
    end
  end

  def valid_mixi_app_mobile_request?
    mixi_request = OAuth::RequestProxy::ActionControllerRequestForMixi.new(request)
    unless OAuth::Signature.verify(mixi_request, :consumer_secret => ENV['CONSUMER_SECRET'])
      reject_invalid_access(mixi_request)
    else
      @valid_mixi_app_request = true
    end
  rescue OAuth::Signature::UnknownSignatureMethod => e
    logger.info e
    reject_invalid_access
  rescue => e
    logger.info e
    reject_invalid_access
  end

  def reject_invalid_access(request = nil)
    if self.class.reject_invalid_access?
      if request
        signature = OAuth::Signature.build(request, :consumer_secret => ENV["CONSUMER_SECRET"])
        logger.info "Signature base string: #{signature.signature_base_string}"
        logger.info "Genarated signature: #{signature.signature}"
        logger.info "Request signature: #{signature.request.signature}"
      end
      render "public/403.html", :status => 403, :layout => false
    end
  end

  def convert_url_for_mixi_app(url, app_id = params[:opensocial_app_id])
    "http://ma.mixi.net/#{app_id}/?guid=ON&url=#{URI.escape(url)}"
  end

  def redirect_to_full_url_with_convert_url_for_mixi_app(url, status)
    if valid_mixi_app_request
      logger.debug "convert from #{url}"
      url = convert_url_for_mixi_app(url)
      logger.debug "convert to #{url}"
    end
    redirect_to_full_url_without_convert_url_for_mixi_app(url, status)
  end

end
