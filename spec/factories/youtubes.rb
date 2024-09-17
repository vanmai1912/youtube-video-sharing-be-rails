FactoryBot.define do
  factory :youtube do
    title { "Sample Video Title" }
    description { "Sample Video Description" }
    image_url { "http://example.com/sample.jpg" }
    video_url { "https://www.youtube.com/watch?v=sampleid" }
    association :user
  end
end
