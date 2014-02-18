class User < ActiveRecord::Base
  before_save { self.email = email.downcase }               # Transport chart to lowercase before save
  # System will generate a token when user created
  before_save { self.session_token ||= Digest::SHA1.hexdigest(SecureRandom.urlsafe_base64.to_s)}
  
  has_secure_password                                       # Trun password to mojibake in db
  validates :name, presence: true, length: { maximum: 30 }  # Must be input and max charts to input
  # validates :email, format: { with: /\A[^@]+@[^@]+\z/ }, uniqueness: true # Regular expression, unique
  validates :email, format: { with: /\A[^@]+@[^@]+\z/ }, uniqueness: {case_sensitive: false} # Regular expression, don't check uppercase or lowercase
end
