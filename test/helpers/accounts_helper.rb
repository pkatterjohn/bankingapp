require 'test_helper'

class AccountsTransactionTest < ActionController::TestCase
  setup do
    @transaction = Transaction.new
    @account1 = accounts(:test_account1)
    @account2 = accounts(:test_account2)
  end


  test 'Validates Deposit' do
    parameters = {
     "transaction_type"=>"Deposit",
     "acct_to"=>@account1.id,
     "transfer_amount"=>78.0,
     "description"=>"Test Deposit",
     "user_id"=>@account1.user_id
    }

    @transaction.assign_attributes(parameters)
    @transaction.execute_save

    assert_equal(@transaction.description, 'Test Deposit')
    assert_equal(@transaction.transfer_amount, 78.0)
    assert_equal(@transaction.acct_to,  @account1.id)
    assert_equal(@transaction.user_id, @account1.user_id)
    assert_equal(@transaction.transaction_type, 'Deposit')

    assert_equal(@account1.amount + @transaction.transfer_amount, Account.find(@account1.id).amount)
  end

  test 'Validates Expenditure' do
    parameters = {
     "transaction_type"=>"Expenditure",
     "acct_from"=>@account1.id,
     "transfer_amount"=>78.0,
     "description"=>"Test Expenditure",
     "user_id"=>@account1.user_id
    }

    @transaction.assign_attributes(parameters)
    @transaction.execute_save

    assert_equal(@transaction.description, 'Test Expenditure')
    assert_equal(@transaction.transfer_amount, 78.0)
    assert_equal(@transaction.acct_from,  @account1.id)
    assert_equal(@transaction.user_id, @account1.user_id)
    assert_equal(@transaction.transaction_type, 'Expenditure')

    assert_equal(@account1.amount - @transaction.transfer_amount, Account.find(@account1.id).amount)
  end

  test 'Validates Transfer' do
    parameters = {
     "transaction_type"=>"Transfer",
     "acct_from"=>@account1.id,
     "acct_to"=>@account2.id,
     "transfer_amount"=>78.0,
     "description"=>"Test Transfer",
     "user_id"=>@account1.user_id
    }

    @transaction.assign_attributes(parameters)
    @transaction.execute_save

    assert_equal(@transaction.description, 'Test Transfer')
    assert_equal(@transaction.transfer_amount, 78.0)
    assert_equal(@transaction.acct_from,  @account1.id)
    assert_equal(@transaction.acct_to,  @account2.id)
    assert_equal(@transaction.user_id, @account1.user_id)
    assert_equal(@transaction.transaction_type, 'Transfer')

    assert_equal(@account1.amount - @transaction.transfer_amount, Account.find(@account1.id).amount)
    assert_equal(@account2.amount + @transaction.transfer_amount, Account.find(@account2.id).amount)
  end
end

