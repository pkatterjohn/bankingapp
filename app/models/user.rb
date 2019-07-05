class User < ActiveRecord::Base
  validates :login, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :admin, presence: true
  belongs_to :organization


  def name
    (self.first_name + " " + self.last_name)
  end

  def how_rich
    self.get_accounts.pluck(:amount).inject(0, :+)
  end

  def get_accounts
    Account.where(user_id: self.id)
  end

  def initialize_accounts
    sav_acct = Account.new(name: "#{self.first_name}'s Savings", user_id: self.id, account_type: "Savings", amount: 20.00)
    sav_acct.save!
    chk_acct = Account.new(name: "#{self.first_name}'s Checking", user_id: self.id, account_type: "Checking", amount: 20.00)
    chk_acct.save!
  end
end
