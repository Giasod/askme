require 'openssl'

class User < ApplicationRecord
  ITERATIONS = 20_000
  DIGEST = OpenSSL::Digest::SHA256.new
  USERNAME_REGEX = /\A\w+\Z/.freeze
  COLOR_REGEX = /\A#?([\h]{3}){1,2}\z/i.freeze

  attr_accessor :password

  has_many :questions, dependent: :destroy

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP },
                    uniqueness: true,
                    presence: true

  validates :username, format: { with: USERNAME_REGEX },
                       length: { maximum: 40 },
                       uniqueness: true,
                       presence: true

  validates :color, format: { with: COLOR_REGEX }

  validates :password, presence: true, confirmation: true, on: :create

  before_validation :username_and_email_downcase
  before_save :encrypt_password

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

  def username_and_email_downcase
    username&.downcase!
    email&.downcase!
  end
end
