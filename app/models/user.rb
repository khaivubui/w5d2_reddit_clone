# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  attr_reader :password
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :username, :password_digest, :session_token, presence: true
  validates :username, :password_digest, uniqueness: true
  after_initialize :ensure_session_token

  has_many :subs,
           foreign_key: :moderator_id,
           inverse_of: :moderator,
           dependent: :destroy

  has_many :posts,
           foreign_key: :author_id,
           inverse_of: :author,
           dependent: :destroy

  def self.generate_unique_token
    new_token = SecureRandom.urlsafe_base64
    while User.find_by(session_token: new_token)
      new_token = SecureRandom.urlsafe_base64
    end
    new_token
  end

  def self.find_by_credentials(options)
    user = User.find_by(username: options[:username])
    return user if user &&
        BCrypt::Password.new(user.password_digest).is_password?(options[:password])
    nil
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def ensure_session_token
    self.session_token ||= User.generate_unique_token
  end
end
