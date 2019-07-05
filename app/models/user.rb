class User < ActiveRecord::Base
  validates :login, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :admin, presence: true
  belongs_to :organization
end
