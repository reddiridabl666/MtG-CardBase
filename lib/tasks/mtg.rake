require 'open-uri'

namespace :mtg do
  desc "parse MTGJson set and fill db with it's data"
  task :add_set, [:set_name] => :environment do |_, args|
    set_path = Rails.root.join('card_data', "#{args.set_name}.json")
    set = ActiveSupport::JSON::decode(File.read(set_path))['data']

    expansion = Expansion.find_by(name: set['name'])
    expansion ||= Expansion.create(name: set['name'], card_num: set['baseSetSize'],
                                 release_date: set['releaseDate'], code: set['keyruneCode'])
    set['cards'].each do |card|
      base_card = Card.find_by(name: card['name'])
      base_card ||= Card.create(name: card['name'], power: card['power'], toughness: card['toughness'],
                      text: card['text'], types: card['supertypes'], subtypes: card['subtypes'],
                      mana_value: card['manaValue'], manacost: card['manaCost'],
                      legendary: card['supertypes'].include?('Legendary'))

      if CardInstance.find_by(card_id: base_card.id, expansion_id: expansion.id).nil?
        card_instance = CardInstance.create(flavour_text: card['flavorText'], expansion_id: expansion.id,
                            card_id: base_card.id, rarity: CardInstance.rarity_from_string(card['rarity']))

        image_url = "https://api.scryfall.com/cards/#{card['identifiers']['scryfallId']}?format=image"
        downloaded_image = URI.open(image_url)
        card_instance.image.attach(io: downloaded_image, filename: "#{card['identifiers']['scryfallId']}.png")
      end
    end
  end
end
