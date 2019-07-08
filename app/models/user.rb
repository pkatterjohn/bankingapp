class User < ActiveRecord::Base
  attr_accessor :remember_token
  validates :login, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :admin, presence: true
  belongs_to :organization

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, on: :create

  def name
    (self.first_name + " " + self.last_name)
  end

  def how_rich
    self.get_accounts.pluck(:amount).inject(0, :+)
  end

  def get_accounts
    Account.where(user_id: self.id)
  end

  def get_transactions
    Transaction.where(user_id: self.id)
  end

  #Initializes Accounts for New User
  def initialize_accounts
    sav_acct = Account.new(name: "#{self.first_name}'s Savings", user_id: self.id, account_type: "Savings", amount: 20.00)
    sav_acct.save!
    chk_acct = Account.new(name: "#{self.first_name}'s Checking", user_id: self.id, account_type: "Checking", amount: 20.00)
    chk_acct.save!
  end

  #Remembers User
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  #Forgets User
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Returns the hash digest of the given string.
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
end
