module DramasHelper

  def title_image_tag(drama, options = {})
    return "" if drama.blank? or drama.title_image.blank?
    options = { :style => "border:none;"}
    image_tag("title_images/#{drama.title_image}", options)
  end
end
