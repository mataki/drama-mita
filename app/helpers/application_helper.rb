# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def have_wathed?
    return @result unless @result.nil?
    @result = ((current_user.watches_count||0) > 0)
  end

  def encoding
    mobile = controller.request.mobile
    if mobile && !(mobile.instance_of?(Jpmobile::Mobile::Vodafone)||mobile.instance_of?(Jpmobile::Mobile::Softbank))
      "Shift-JIS"
    else
      "UTF-8"
    end
  end

  def logo_image_path
    (::Rails.env == "production") ? '/images/drama-mita-logo.jpg' : '/images/drama-mita-logo-st.jpg'
  end
end
