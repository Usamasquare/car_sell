class User < ApplicationRecord
  include Pay::Billable
  pay_customer
  has_many :ads, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_ads, through: :favorites, source: :ad
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:login]

  validates :phone, :username, uniqueness: true
  validates_format_of :phone, with: /^[0-9]{11}$/, :multiline => true
  validate :password_validations
  validates_format_of :username, with: /^[-@.\/#&+\w\s]*$/, :multiline => true


  attr_writer :login

  def password_validations
    rules = {
      " must contain at least one uppercase letter"  => /[A-Z]+/,
      " length must be greater than 8"               => /(?=.{8,})/,
      " must contain at least one special character" => /[^A-Za-z0-9]+/
    }

    rules.each do |message, regex|
      errors.add( :password, message ) unless password.match( regex ) if password.present?
    end
  end

  def login
    @login || self.phone || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(['lower(phone) = :value OR lower(email) = :value', { value: login.downcase }]).first
    elsif conditions.has_key?(:phone) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

end
