class User < ApplicationRecord
  include Pay::Billable
  pay_customer

  has_many :ads, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_ads, through: :favorites, source: :ad

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:login]

  PK_PHONE_REGEX = /^(\+92)-{0,1}\d{3}-{0,1}\d{7}$/.freeze

  validates :phone, :username, uniqueness: true
  validate :password_validations
  validates_format_of :username, with: %r{^[-@./#&+\w\s]*$}, multiline: true
  validates :phone, format: { with: PK_PHONE_REGEX, message: 'format should be +92-3XX-XXXXXXX', multiline: true }

  attr_writer :login

  def password_validations
    rules = {
      ' must contain at least one uppercase letter' => /[A-Z]+/,
      ' length must be greater than 8' => /(?=.{8,})/,
      ' must contain at least one special character' => /[^A-Za-z0-9]+/
    }

    rules.each do |message, regex|
      errors.add(:password, message) if password.present? && !password.match(regex)
    end
  end

  def login
    @login || phone || email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions.to_h).where(['lower(phone) = :value OR lower(email) = :value', { value: login.downcase }]).first
    elsif conditions.key?(:phone) || conditions.key?(:email)
      where(conditions.to_h).first
    end
  end

  def toggle_favorite_ad(ad)
    # implement
  end
end
