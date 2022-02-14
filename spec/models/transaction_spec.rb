require_relative '../rails_helper.rb'

RSpec.describe Transaction, :type => :model do
  before(:each) do
    @transaction = validTransaction()
  end

  it "is valid with all parameters" do
    expect(@transaction.save!).to be_truthy
  end

  it "is not valid without transfer_amount" do
    @transaction.transfer_amount = nil
    expect{@transaction.execute_save}.to raise_error('transfer_amount cannot be nil')
  end

  it "is not valid with negative transfer_amount" do
    @transaction.transfer_amount = -4
    expect{@transaction.execute_save}.to raise_error('transfer_amount cannot be negative')
  end

  it "is not valid with transfer_amount of 0" do
    @transaction.transfer_amount = 0
    expect{@transaction.execute_save}.to raise_error('transfer_amount cannot be 0')
  end

  context "checks if transfer_amount is numeric" do
    it "when transfer_amount is string" do
      @transaction.transfer_amount = '12'
      expect{@transaction.execute_save}.to raise_error('transfer_amount must be numeric')
    end

    it "when transfer_amount is an Object" do
      expect{@transaction.execute_save}.to raise_error('transfer_amount must be numeric')
    end
  end

  it "is not valid without belonging to a user"
  it "is not valid without transaction_type"
  it "is not valid with invalid TransactionType"
  it "type 'Deposit' adds money to account"
  it "type 'Expenditure' removes money from account"
  it "type 'Expenditure' throws error if insufficient funds"
  it "type 'Transfer' moves money between accounts"
  it "type 'Transfer' throws error if insufficient funds"
end

def validTransaction
  user = new_user()
  user.save
  user.initialize_accounts
  account_one = user.get_accounts.first
  account_two = user.get_accounts.second
  return Transaction.new(
    transaction_type: "Deposit",
    transfer_amount: 20.00,
    acct_to: account_one.id,
    acct_from: account_two.id,
    user: user
  )
end

def new_user
  return User.create(
    first_name: "First Name",
    last_name: "Last Name",
    admin: 0,
    login: "User1000",
    password: "Password1000",
    organization_id: 1
  )
end
