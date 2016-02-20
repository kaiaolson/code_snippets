class User < ActiveRecord::Base
  has_many :code_snippets, dependent: :nullify
  has_secure_password

  validates :email, presence: true, uniqueness: true
end
