class Transaction < ActiveRecord::Base
  validates :transaction_type, presence: true
  validates :acct_from, presence: true
  validates :amount, presence: true
  belongs_to :account
end
