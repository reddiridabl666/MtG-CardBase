module ApplicationHelper
  def process_text(str, size=MTG_SYMBOL_SIZE)
    return if str.nil?
    replace_mtg_symbols(str.strip.gsub(/\n/, '<br/>'), size).html_safe
  end

  MTG_SYMBOL_SIZE_BIG = '24x24'.freeze
  MTG_SYMBOL_SIZE = '18x18'.freeze

  def replace_mtg_symbols(str, size=MTG_SYMBOL_SIZE)
    return if str.nil?

    str.gsub(Card::MTG_SYMBOL) do |match|
      image_tag("symbols/#{match[1...-1].delete('/').downcase}.svg", size: size)
    end
  end

  def get_mtg_symbols(str)
    puts str
    str.scan(Card::MTG_SYMBOL).map { |match| "symbols/#{match.first[1...-1].delete('/').downcase}.svg" }
  end
end
