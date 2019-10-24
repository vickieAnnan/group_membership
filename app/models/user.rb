class User < ApplicationRecord
  has_secure_password
  has_many :groups
  has_many :groupsat, through: :attendees, class_name: "Group", foreign_key: "group_id"
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, :password, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  validates :password, length: { minimum:8 }
  

  before_save :downcase_email

  after_save :successfully_created


  private
    def downcase_email
      self.email.downcase!
    end

    def successfully_created
      puts "Successfully created a new user"
    end

end
