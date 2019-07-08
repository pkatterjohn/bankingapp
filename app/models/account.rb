class Account < ActiveRecord::Base
  validates :name, presence: true
  validates :amount, presence: true, numericality: {greater_than_or_equal_to: 0}
  validates :account_type, presence: true
  belongs_to :user
end
