class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:login]

  validates :phone, :username, uniqueness: true
  # only allow letter, number, underscore and punctuation.
  validates_format_of :phone, with: /^[0-9]{11}$/, :multiline => true
  validates_format_of :password, with: /^(?=.*[A-Z])(?=.*[!@#\$%\^&\*])(?=.{8,})/, :multiline => true
  validates_format_of :username, with: /^[-@.\/#&+\w\s]*$/, :multiline => true
  #validates :email,  presence: true, if: -> { phone.blank? }
  #validates :phone,  presence: true, if: -> { email.blank? }

  attr_writer :login

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
