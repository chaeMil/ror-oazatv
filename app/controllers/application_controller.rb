class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery with: :exception
  before_action :set_locale, :load_locales

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def load_locales
    @languages = Language.all
    @languages.each do |language|
      I18n.available_locales << [language['locale']]
    end
  end
end
