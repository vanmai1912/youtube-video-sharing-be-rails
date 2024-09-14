# db/seeds.rb

# Array of hashes containing specific names and video_urls for YouTube videos
youtube_data = [
  { title: "Funny Cats Compilation", video_url: "https://www.youtube.com/watch?v=abc123" },
  { title: "Top 10 Gaming Moments", video_url: "https://www.youtube.com/watch?v=def456" },
  { title: "How to Cook Pasta", video_url: "https://www.youtube.com/watch?v=ghi789" },
  { title: "Best Travel Destinations", video_url: "https://www.youtube.com/watch?v=jkl012" },
  { title: "DIY Home Improvement", video_url: "https://www.youtube.com/watch?v=mno345" },
  { title: "Latest Tech Gadgets", video_url: "https://www.youtube.com/watch?v=pqr678" },
  { title: "Workout Routines for Beginners", video_url: "https://www.youtube.com/watch?v=stu901" },
  { title: "Popular Music Hits", video_url: "https://www.youtube.com/watch?v=vwx234" },
  { title: "Amazing Science Experiments", video_url: "https://www.youtube.com/watch?v=yza567" },
  { title: "Top 10 Movie Trailers", video_url: "https://www.youtube.com/watch?v=bcd890" },
  { title: "Gardening Tips and Tricks", video_url: "https://www.youtube.com/watch?v=efg123" },
  { title: "Healthy Smoothie Recipes", video_url: "https://www.youtube.com/watch?v=ghi456" },
  { title: "Ultimate Prank Videos", video_url: "https://www.youtube.com/watch?v=jkl789" },
  { title: "Best Football Highlights", video_url: "https://www.youtube.com/watch?v=mno012" },
  { title: "Amazing Magic Tricks", video_url: "https://www.youtube.com/watch?v=pqr345" },
  { title: "Learn to Play Guitar", video_url: "https://www.youtube.com/watch?v=stu678" },
  { title: "Incredible Nature Documentaries", video_url: "https://www.youtube.com/watch?v=vwx901" },
  { title: "Product Reviews and Unboxings", video_url: "https://www.youtube.com/watch?v=yza234" },
  { title: "Life Hacks You Need to Know", video_url: "https://www.youtube.com/watch?v=abc456" },
  { title: "Incredible Space Discoveries", video_url: "https://www.youtube.com/watch?v=def789" },
  { title: "Fun DIY Crafts", video_url: "https://www.youtube.com/watch?v=ghi012" }
]

# Create YouTube records with the specified names and video_urls
youtube_data.each do |video|
  Youtube.create(video)
end
