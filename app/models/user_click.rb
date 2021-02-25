class UserClick < ApplicationRecord
  validates :path_name, presence: true
  validates :clicks_amount, presence: true
end
