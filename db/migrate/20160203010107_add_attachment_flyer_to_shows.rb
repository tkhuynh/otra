class AddAttachmentFlyerToShows < ActiveRecord::Migration
  def self.up
    change_table :shows do |t|
      t.attachment :flyer
    end
  end

  def self.down
    remove_attachment :shows, :flyer
  end
end
