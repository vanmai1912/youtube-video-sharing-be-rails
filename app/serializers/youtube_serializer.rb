class YoutubeSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :video_url, :image_url
end
