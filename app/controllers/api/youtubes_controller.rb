module Api
  class YoutubesController < Api::ApplicationController
    YOUTUBE_URL_REGEX = %r{\A(?:https?://)?(?:www\.)?(?:youtube\.com|youtu\.be)/(?:watch\?v=)?([a-zA-Z0-9_-]{11})\z}

    def index
      page_number = params[:page].to_i > 0 ? params[:page].to_i : 1
      youtubes = Youtube.page(page_number).per(10)
      render json: {
        data: ActiveModelSerializers::SerializableResource.new(youtubes, each_serializer: YoutubeSerializer).as_json,
        meta: {
          current_page: youtubes.current_page,
          total_pages: youtubes.total_pages,
          total_count: youtubes.total_count
        },
        status: :ok
      }, status: :ok
    end

    def create
      video_url = params['video_url']
      if video_url.match?(YOUTUBE_URL_REGEX)
        craw = CrawlDataYoutube.new(video_url).fetch_video_info
        if craw[:title].present?
          youtube = Youtube.create(
            title: craw[:title],
            description: craw[:description],
            image_url: craw[:thumbnail_url],
            video_url: video_url
          )
    
          if youtube.persisted?
            render json: { message: 'Video created successfully', status: :ok }, status: :ok
          else
            render json: { error: 'Failed to create video', status: :unprocessable_entity }, status: :unprocessable_entity
          end
        else
          render json: {
            error: "Invalid YouTube URL path",
            status: :unprocessable_entity
          }, status: :unprocessable_entity
        end
      else
        render json: {
          error: "Invalid YouTube URL format",
          status: :unprocessable_entity
        }, status: :unprocessable_entity
      end
    end
  end
end
