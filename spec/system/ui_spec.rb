require 'rails_helper'

RSpec.describe "UI", type: :system do
  before do
    driven_by(:selenium)
    app.default_url_options = { locale: 'en' }
  end

  context 'not authorized' do
    it 'filters cards' do
      visit root_path

      click_on I18n.t('filters')
      expect(page).to have_current_path root_path

      fill_in I18n.t('name'), with: 'Gearhulk'
      fill_in 'cost_ge', with: 6
      uncheck 'color_w'

      click_on I18n.t('search')

      expect(page).to have_content 'Combustible Gearhulk'
      expect(page).not_to have_content 'Cataclysmic Gearhulk'
      expect(page).not_to have_content 'Verdant Gearhulk'

      fill_in I18n.t('name'), with: 'TEST_DATA'
      click_on I18n.t('search')

      expect(page).to have_content I18n.t('no-cards')
    end
  end
end
