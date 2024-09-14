require 'mechanize'

class CrawlDataYoutube

  def initialize(url)
    @url = url
  end

  def fetch_video_info
    agent = Mechanize.new
    agent.user_agent_alias = 'Windows Chrome'
    page = agent.get(@url)
    title = page.at('meta[name="title"]')['content'] rescue 'No title found'
    description = page.at('meta[name="description"]')['content'] rescue 'No description found'
    video_id = extract_video_id(@url)
    thumbnail_url = "https://img.youtube.com/vi/#{video_id}/maxresdefault.jpg"
    { title: title, description: description, thumbnail_url: thumbnail_url }
  end
  
  private
  
  def extract_video_id(url)
    # Extract the video ID from a standard YouTube URL
    url[/v=([a-zA-Z0-9_-]{11})/, 1] || url[/youtu\.be\/([a-zA-Z0-9_-]{11})/, 1]
  end  
end
