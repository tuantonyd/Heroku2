class AddAttachmentFileToItemImages < ActiveRecord::Migration[5.1]
  def self.up
    change_table :item_images do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :item_images, :file
  end
end
