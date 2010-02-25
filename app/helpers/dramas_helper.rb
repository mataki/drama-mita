module DramasHelper

  def drama_title_image(drama, show_drama_title_image = true)
    @content_for_drama_title_image = link_to title_image_tag(drama), drama
    @show_drama_title_image = show_drama_title_image
  end

  def show_drama_title_image?
    @show_drama_title_image
  end

  def title_image_tag(drama, options = {})
    return "" if drama.blank? or drama.title_image.blank?
    options = { :style => "border:none;"}.update(options)
    image_tag("title_images/#{drama.title_image}", options)
  end
end
