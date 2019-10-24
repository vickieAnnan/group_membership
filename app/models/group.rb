class Group < ApplicationRecord
  belongs_to :user
  has_many :attendees
  has_many :users, through: :attendees

 
  validates :org_name, presence: true, length: { minimum:5 }
  validates :description, presence: true, length: { minimum:10 }
end
