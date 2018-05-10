class LiveStreamController < ApplicationController
  require 'moneta'
  before_action :setup_moneta

  def view

  end

  private

  def setup_moneta
    @store = Moneta.new(:File, dir: 'local_config/livestream')
  end
end