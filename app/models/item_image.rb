class ItemImage < ApplicationRecord
  belongs_to :item
  has_attached_file :file
  validates_attachment_content_type :file, content_type: /\Aimage\/.*\z/


end
