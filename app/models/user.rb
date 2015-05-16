class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

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
