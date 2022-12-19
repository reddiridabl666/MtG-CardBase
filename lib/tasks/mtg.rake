namespace :mtg do
  desc "parse MTGJson set and fill db with it's data"
  task :add_set, [:set_name] => :environment do |_, args|
    set_path = Rails.root.join('card_data', "#{args.set_name}.json")
    set = ActiveSupport::JSON::decode(File.read(set_path))['data']

    expansion = Expansion.create(name: set['name'], card_num: set['baseSetSize'],
                                 release_date: set['releaseDate'], code: set['keyruneCode'])
    set['cards'].each do |card|
      base_card = Card.find_by(name: card['name'])
      if base_card.nil?
        Card.create(name: card['name'], power: card['power'], toughness: card['toughness'],
                    text: card['rulings']['text'], types: card['supertypes'], subtype: card['subtypes'].join)
      end
    end
  end
end
