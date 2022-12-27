# frozen_string_literal: true

module ApplicationHelper
  def process_text(str, size=MTG_SYMBOL_SIZE)
    return if str.nil?
    replace_mtg_symbols(str.strip.gsub(/\n/, '<br/>'), size).html_safe
  end

  MTG_SYMBOL_SIZE_BIG = '24x24'
  MTG_SYMBOL_SIZE_MID = '20x20'
  MTG_SYMBOL_SIZE = '18x18'
  MTG_SYMBOL_SIZE_MIN = '14x14'

  def replace_mtg_symbols(str, size=MTG_SYMBOL_SIZE)
    return if str.nil?

    str.gsub(Card::MTG_SYMBOL) do |match|
      image_tag("symbols/#{match[1...-1].delete('/').downcase}.svg", size: size)
    end.html_safe
  end

  def get_mtg_symbols(str)
    str.scan(Card::MTG_SYMBOL).map { |match| "symbols/#{match.first[1...-1].delete('/').downcase}.svg" }
  end

  def checked?(key)
    @params[key].present? ? !@params[key].to_i.zero? : false
  end

  def add_locale(locale)
    url_for(params.clone.permit!.merge(locale: locale, only_path: true))
  end
end
