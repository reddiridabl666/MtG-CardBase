module ApplicationHelper
  def process_text(str, size=MTG_SYMBOL_SIZE)
    replace_mtg_symbols(str.strip.gsub(/\n/, '<br/>'), size).html_safe
  end

  MTG_SYMBOL_SIZE_BIG = '24x24'.freeze
  MTG_SYMBOL_SIZE = '18x18'.freeze

  def replace_mtg_symbols(str, size=MTG_SYMBOL_SIZE)
    str.gsub(Card::MTG_SYMBOL) do |match|
      image_tag("symbols/#{match[1...-1].downcase}.svg", size: size)
    end
  end

  def get_mtg_symbols(str)
    str.scan(Card::MTG_SYMBOL).map { |match| "symbols/#{match[1...-1].join.downcase}.svg" }
  end
end
