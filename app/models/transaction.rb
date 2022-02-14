class Transaction < ActiveRecord::Base
  validates :transaction_type, presence: true
  validates :transfer_amount, presence: true, numericality: {greater_than: 0}

  belongs_to :user
  # has_one :transaction_category
  #
  # after_initialize :init
  #
  # def init
  #   self.transaction_category = TransactionCategory.default()
  # end

  def execute_save
    raise "Accounts must be different" if self.acct_to == self.acct_from

    #Implement check validations before executing

    #Check transfer_amount
    raise "transfer_amount cannot be nil" if self.transfer_amount == nil
    raise "transfer_amount cannot be negative" if self.transfer_amount < 0
    raise "transfer_amount cannot be 0" if self.transfer_amount == 0

    self.save if self.execute
  end

  def execute
    case self.transaction_type
    when 'Deposit'
      add_money(self.acct_to, self.transfer_amount)
    when 'Transfer'
      subtract_money(self.acct_from, self.transfer_amount)
      add_money(self.acct_to, self.transfer_amount)
    when 'Expenditure'
      subtract_money(self.acct_from, self.transfer_amount)
    else
      return false
    end
  end


  private
  def add_money(acct_to, amount)
    account_to = Account.find(acct_to)
    account_to.amount = account_to.amount + amount
    account_to.save!
  end

  def subtract_money(acct_from, amount)
    account_from = Account.find(acct_from)
    new_amount = account_from.amount - amount
    raise "Not enougn money in #{account_from.name} to cover transaction." if new_amount < 0
    account_from.amount = new_amount
    account_from.save!
  end
end
