require 'digest/md5'

class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  has_many :questions, dependent: :destroy
  has_many :answers, :through => :questions, :source => :answers
  attr_accessor :password, :new_password, :previous_email, :previous_username
  before_save :encrypt_password
  before_save :get_gravatar

  validates_confirmation_of :password
  validates_confirmation_of :new_password, :if => Proc.new {|user| !user.new_password.nil? && !user.new_password.empty? }
  validates_presence_of :password, :on => :create
  validates_presence_of :email, :if => Proc.new {|user| user.previous_email.nil? || user.email != user.previous_email}
  validates_presence_of :username, :if => Proc.new {|user| user.previous_username.nil? || user.username != user.previous_username}
  validates_uniqueness_of :email, :if => Proc.new {|user| user.previous_email.nil? || user.email != user.previous_email}
  validates_uniqueness_of :username, :if => Proc.new {|user| user.previous_username.nil? || user.username != user.previous_username}

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def get_gravatar
    email_address = email
    hash = Digest::MD5.hexdigest(email_address)
    self.avatar = "https://www.gravatar.com/avatar/#{hash}.png"
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end
