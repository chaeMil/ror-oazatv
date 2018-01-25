module Admin
  class LiveStreamController < AdminController
    require 'moneta'
    store = Moneta.new(:File, dir: 'livestream')

    def edit
    end

    def save
    end

  end
end