class AddUserIdToYoutubes < ActiveRecord::Migration[7.1]
  def change
    add_reference :youtubes, :user, null: false, foreign_key: true
  end
end
