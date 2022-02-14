require_relative '../rails_helper.rb'

RSpec.describe Account, :type => :model do
    it "is valid with valid attributes" do
      account = Account.new(
        name: 'Jim',
        amount: 100.00,
        account_type: 'Checking',
        user_id: 1
      )
      expect(account.save).to be_truthy
    end
    it "is not valid without a name" do
      account = Account.new(
        amount: 100.00,
        account_type: 'Checking',
        user_id: 1
      )
      expect(account.save).to be_falsy
    end
    it "is valid without an amount, defaults to 1000" do
      account = Account.new(
        name: 'Jim',
        account_type: 'Checking',
        user_id: 1
      )
      expect(account.save).to be_truthy
      expect(account.amount).to eq 1000
    end
    it "is not valid without an account_type" do
      account = Account.new(
        name: 'Jim',
        amount: 100.00,
        user_id: 1
      )
      expect(account.save).to be_falsy
    end
    it "is not valid without belonging to a user" do
      account = Account.new(
        name: 'Jim',
        amount: 100.00,
        account_type: 'Checking',
      )
      expect{account.save}.to raise_error(ActiveRecord::StatementInvalid)
    end
end
