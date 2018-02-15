module Admin
  class LiveStreamController < AdminController
    require 'moneta'
    before_action :setup_moneta

    def edit

    end

    def save
      @languages = Language.all
      @store['youtube_id'] = params['youtube_id']
      @store['online'] = params['online']
      @languages.each do |language|
        @store["text_#{language['locale']}"] = params["text_#{language['locale']}"]
      end
      @store.close
      redirect_to admin_livestream_path, notice: 'Saved'
    end

    private
    def setup_moneta
      @store = Moneta.new(:File, dir: 'local_config/livestream')
    end
  end
end