class User < ActiveRecord::Base
  has_many :code_snippets, dependent: :nullify
  has_secure_password

  validates :email, presence: true, uniqueness: true

  def full_name
    "#{first_name} #{last_name}"
  end
end
