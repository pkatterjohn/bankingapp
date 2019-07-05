class Organization < ActiveRecord::Base
  validates :external_id, uniqueness: true
  validates :name, presence: true
end
