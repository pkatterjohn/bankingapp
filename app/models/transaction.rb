class Transaction < ActiveRecord::Base
  validates :transaction_type, presence: true
  belongs_to :account
end
