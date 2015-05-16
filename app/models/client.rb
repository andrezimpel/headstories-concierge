class Client < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :invitable, :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  acts_as_token_authenticatable

  # associations
  has_many :appointments, dependent: :destroy


  # valiations
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :email, presence: true
  validates_uniqueness_of :email


  before_create :generate_consent_token
  def generate_consent_token
    self.consent_token = Time.now.to_i.to_s(30)
  end

  before_create :set_default_consent
  def set_default_consent
    self.consent = 0
  end


  def fullname
    # return real fullname
    if self.firstname != nil && self.lastname != nil
      return self.firstname + " " + self.lastname
    end

    # return fristname if available
    return self.firstname unless self.firstname == nil

    # return email
    return self.email
  end
end
