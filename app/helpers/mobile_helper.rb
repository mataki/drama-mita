module MobileHelper
  def font_size(size = :middle)
    case size
    when :large
      base = 'font-size: 14px;'
      case request.mobile
      when Jpmobile::Mobile::Docomo then 'font-size: large;'
      when Jpmobile::Mobile::Softbank then 'font-size: large;'
      else
        base
      end
    when :small
      base = 'font-size: 10px;'
      case request.mobile
      when Jpmobile::Mobile::Docomo then 'font-size: small;'
      when Jpmobile::Mobile::Softbank then 'font-size: small;'
      else
        base
      end
    else
      base = "font-size: 12px;"
      case request.mobile
      when Jpmobile::Mobile::Docomo then 'font-size: middle;'
      when Jpmobile::Mobile::Softbank then 'font-size: middle;'
      else
        base
      end
    end
  end

  def hr(color = "#000000", size = 2)
    tag('hr', :style => "background-color:#{color}; border-color:#{color}; border-style:solid; height:#{size}px", :color => color, :size => size)
  end
end
