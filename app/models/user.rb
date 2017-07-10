class User < ActiveRecord::Base
  has_many :reviews
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password_confirmation, presence: true
  validates :password, length: { minimum: 8 }

  def self.authenticate_with_credentials(eamil, password)
    user = User.find_by(email: eamil.downcase.strip)
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end
end
