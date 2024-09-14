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

    [title, description]
  end
end
