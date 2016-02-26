class CodeSnippet < ActiveRecord::Base
  belongs_to :language
  belongs_to :user

  validates :title, presence: true

  def self.search(term)
    where("title || body ILIKE ?","%#{term}%")
  end

  def language_name
    language.name
  end

  def user_full_name
    user.full_name
  end

  def self.language_count(language, user)
    private_count = where(language: language, privacy: true, user: user).length
    public_count = where(language: language, privacy: false).length
    (private_count > 0 ) ? (private_count + public_count) : public_count
  end
end
