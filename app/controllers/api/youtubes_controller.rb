module Api
  class YoutubesController < Api::ApplicationController
    YOUTUBE_URL_REGEX = %r{\A(?:https?://)?(?:www\.)?(?:youtube\.com|youtu\.be)/(?:watch\?v=)?([a-zA-Z0-9_-]{11})\z}

    def index
      page_number = params[:page].to_i > 0 ? params[:page].to_i : 1
      youtubes = Youtube.page(page_number).per(10)
      render json: {
        data: youtubes,
        meta: {
          current_page: youtubes.current_page,
          total_pages: youtubes.total_pages,
          total_count: youtubes.total_count
        }
      }
    end

    def create
      if params['video_url'].match?(YOUTUBE_URL_REGEX)
        craw = CrawlDataYoutube.new(video_url).fetch_video_info
        render json: {
          craw: craw,
          status: :ok
        }, status: :ok
      else
        render json: {
          error: "Invalid YouTube URL format",
          status: :unprocessable_entity
        }, status: :unprocessable_entity
      end
    end
  end
end
