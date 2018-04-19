class VideoController < ApplicationController
  before_action :set_archive_item, only: %i[watch]

  def watch

  end

  private
  def set_archive_item
    @archive_item = ArchiveItem.find(params[:hash_id])
  end

  def archive_item_params
    permitted = ArchiveItem.globalize_attribute_names + [:published, :description, :hash_id, :date, :tags, :note, :categories]
    params.require(:archive_item).permit(*permitted)
    new_params = params[:archive_item].as_json
    category_ids = params[:archive_item][:categories].reject {|c| c.empty?}
    categories_db = Category.find(category_ids)
    new_params['categories'] = categories_db
    new_params.to_hash
  end
end