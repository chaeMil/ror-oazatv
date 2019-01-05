class Api::V1::LiveStreamController < ApplicationController

  require 'moneta'
  before_action :setup_moneta

  # GET /live_stream
  def show
    output = {
        youtube_id: @store['youtube_id'],
        text: {}
    }
    Language.all.each do |lang|
      output[:text][lang[:locale]] = @store["text_#{lang[:locale]}"]
    end
    render json: output
  end

  private

  def setup_moneta
    @store = Moneta.new(:File, dir: 'local_config/livestream')
  end
end