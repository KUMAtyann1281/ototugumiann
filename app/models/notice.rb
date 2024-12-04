class Notice < ApplicationRecord

  validates :title,
    presence: true

  validates :body,
    presence: true,
    length: { maximum:200 }
end
