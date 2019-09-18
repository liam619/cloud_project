class Author < ApplicationRecord
  attr_accessor :remember_token

  has_many :books


  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]{3}+\z/i
  VALID_PASS_REGEX = /(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*\W)[\w+\W].{7,}+/

  before_save {self.email = email.downcase}
  validates :name, presence: true, length: {in: 4..30}

  validates :email, presence: true, length: {in: 4..50},
            format: {with: VALID_EMAIL_REGEX,
                     message: ' register with simple format such as james@company.com'},
            uniqueness: {case_sensitive: false}

  validates :password, presence: true,
            format: {with: VALID_PASS_REGEX,
                     message: ' must contains at least a lowercase letter, a uppercase, a digit, a special character and 8+ characters'}
  validates :password_confirmation, presence: true

  has_secure_password

  # Returns the hash digest of the given string.
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions
  def remember
    self.remember_token = Author.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user
  def forget
    update_attribute(:remember_digest, nil)
  end
end
