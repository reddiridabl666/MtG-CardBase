require 'rails_helper'

RSpec.describe "Authorisation", type: :system do
  before do
    driven_by(:selenium)
    app.default_url_options = { locale: 'en' }
  end

  it 'changes page depending on authorisation' do
    visit root_path
    click_on I18n.t('sign_up')
    expect(page).to have_current_path signup_path

    password = 'test_password'
    user_name = 'test_user'

    fill_in I18n.t('user_name'), with: user_name
    fill_in I18n.t('password'), with: password
    fill_in I18n.t('pass_repeat'), with: password

    click_on I18n.t('submit')

    expect(page).to have_current_path root_path
    expect(page).to have_content(I18n.t('new-deck'))
    expect(page).to have_content(I18n.t('users'))
    expect(page).to have_content("#{I18n.t('your')} #{I18n.t('decks')}")

    click_on I18n.t('sign_out')

    expect(page).to have_current_path root_path
    expect(page).not_to have_content(I18n.t('new-deck'))
    expect(page).not_to have_content(I18n.t('users'))
    expect(page).not_to have_content("#{I18n.t('your')} #{I18n.t('decks')}")
  end

  it "doesn't allow to visit certain pages when unauthorized" do
    visit users_path
    expect(page).to have_current_path login_path

    visit deck_format_path
    expect(page).to have_current_path login_path

    visit edit_deck_path
    expect(page).to have_current_path decks_path
  end
end
