class CreateYoutubes < ActiveRecord::Migration[7.1]
  def change
    create_table :youtubes do |t|
      t.string :title
      t.string :video_url
      t.string :description
      t.string :image_url

      t.timestamps
    end
  end
end
