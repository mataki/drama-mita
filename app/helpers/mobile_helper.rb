module MobileHelper
  def font_size(size = :middle)
    case size
    when :large
      base = 'font-size: 16px;'
      case request.mobile
      when Jpmobile::Mobile::Docomo then 'font-size: xx-large;'
      when Jpmobile::Mobile::Softbank then 'font-size: xx-large;'
      else
        base
      end
    when :small
      base = 'font-size: 10px;'
      case request.mobile
      when Jpmobile::Mobile::Docomo then 'font-size: xx-small;'
      when Jpmobile::Mobile::Softbank then 'font-size: small;'
      else
        base
      end
    else
      ""
    end
  end
end
