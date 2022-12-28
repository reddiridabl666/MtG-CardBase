require 'rails_helper'

def create_deck
  visit root_path

  click_on I18n.t('new-deck')
  fill_in I18n.t('name'), with: 'test_deck'
  click_on I18n.t('create')
end

RSpec.describe "DeckBuilding", type: :system do
  let(:password) { 'test_password' }
  let(:user_name) { 'test_user' }

  before do
    driven_by(:selenium)
    app.default_url_options = { locale: 'en' }

    visit signup_path

    fill_in I18n.t('user_name'), with: user_name
    fill_in I18n.t('password'), with: password
    fill_in I18n.t('pass_repeat'), with: password

    click_on I18n.t('submit')
  end

  before :each do
    visit login_path

    fill_in I18n.t('user_name'), with: user_name
    fill_in I18n.t('password'), with: password

    click_on I18n.t('submit')
  end

  it 'allows to create and edit deck' do
    initial_deck_count = Deck.count

    create_deck

    click_on I18n.t('save')

    expect(Deck.count).to eq initial_deck_count + 1

    click_on I18n.t('edit')

    initial_card_count = CardInDeck.count

    all('.add-btn')[0].click
    all('.add-btn')[0].click
    all('.add-btn')[2].click

    click_on I18n.t('save')

    expect(CardInDeck.count).to eq initial_card_count + 2

    click_on I18n.t('edit', wait: 10)

    all('.remove-btn').each { |btn| btn&.click }
    all('.add-btn')[1].click

    click_on I18n.t('save')

    expect(CardInDeck.count).to eq initial_card_count + 1

    click_on I18n.t('copy', wait: 10)
    click_on I18n.t('edit', wait: 10)

    expect(Deck.count).to eq initial_deck_count + 2

    page.accept_alert 'Are you sure?' do
      click_on I18n.t('delete', wait: 10)
    end

    sleep(1)

    expect(Deck.count).to eq initial_deck_count + 1
  end
end
