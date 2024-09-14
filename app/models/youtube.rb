class Youtube < ApplicationRecord
  after_create :send_notification

  belongs_to :user
  
  def send_notification
    if user.present? && title.present?
      message = "#{user.first_name} just shared a video with title: #{title}"
      
      ActionCable.server.broadcast("notification_channel", { message: message })
    end
  end
  
end
