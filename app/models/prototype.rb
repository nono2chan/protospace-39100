class Prototype < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  validates :title, presence: true
  validates :catch_copy, presence: true
  validates :concept, presence: true
  validates :image, presence: true
  has_many :comments, dependent: :destroy
  # attr_accessor :name, :description
  # validates :email, presence: true
  # validates :encrypted_password, presence: true
  # validates :user_name, presence: true
  # validates :profile, presence: true
  # validates :occupation, presence: true
  # validates :position, presence: true
  
end
