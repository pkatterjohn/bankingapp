class Account < ActiveRecord::Base
  validates :name, presence: true
  validates :amount, presence: true, numericality: {greater_than_or_equal_to: 0}
  validates :account_type, presence: true
  belongs_to :user

  def deposit(amount)
    transaction = Transaction.new(transaction_type: "Deposit", transfer_amount: amount.to_f, acct_to: self.id, user_id: self.user_id)
    transaction.execute_save
  end
end
