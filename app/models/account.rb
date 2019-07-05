class Account < ActiveRecord::Base
  validates :name, presence: true
  validates :amount, presence: true
  validates :account_type, presence: true
  belongs_to :user
end
