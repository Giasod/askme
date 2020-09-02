require 'openssl'

class User < ApplicationRecord
  ITERATIONS = 20_000
  DIGEST = OpenSSL::Digest::SHA256.new

  attr_accessor :password

  has_many :questions

  validates :email, :username, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true, on: :create

  validates :username, length: { maximum: 40, too_long: '%{count} characters is the maximum allowed' }

  validates :email, format: { with: /[\-\w+.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+/i }
  validates :username, format: { with: /\w/i }

  before_validation :username_downcase
  before_save :encrypt_password

  def encrypt_password
    if password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(
          password, password_salt, ITERATIONS, DIGEST.length, DIGEST
        )
      )
    end
  end

  def self.hash_to_string(password_hash)
    password_hash.unpack1('H*')
  end

  def self.authenticate(email, password)
    user = find_by(email: email)

    return nil unless user.present?

    hashed_password = User.hash_to_string(
      OpenSSL::PKCS5.pbkdf2_hmac(
        password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST
      )
    )

    return user if user.password_hash == hashed_password

    nil
  end

  private

  def username_downcase
    self.username = username.downcase!
  end
end
