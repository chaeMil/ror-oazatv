module Admin
  class PhotosController < AdminController
    if params[:images]
      params[:images].each do |image|
        @photo_album.photos.create(image: image)
      end
    end
  end
end