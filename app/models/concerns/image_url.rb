module ImageUrl
  extend ActiveSupport::Concern

  included do
    mount_uploader :image, ImageUploader
  end

  def image_path(size = :square)
    image? ? image.url(size) : "/image/profile.png"
  end

  def upload_image_path(size = :square)
    image? ? image.url(size) : "/image/profile.png"
  end
end
