require 'digest'

class User < ActiveRecord::Base
	attr_accessor :password
	attr_accessible :nom, :email, :password, :password_confirmation

	validates_presence_of :nom
	validates_length_of :nom, :maximum => 50
	
	validates_presence_of :email
	validates_format_of :email, :with => /@/

	validates_uniqueness_of :email

	validates_presence_of :password_confirmation
	validates_confirmation_of :password
	validates_length_of :password, :within => 6..40

	before_save :encrypt_password

	# Retourne true si mot de passe correspond.
	def has_password?(password_soumis) 
		encrypted_password == encrypt(password_soumis)
	end

	def self.authenticate(email, submited_password)
		user = find_by_email(email)
		return nil if user.nil?
		return user if user.has_password?(submited_password)
	end

	private

		def encrypt_password
				self.salt = make_salt if new_record?
				self.encrypted_password = encrypt(password)
		end

		def encrypt(string) 
			secure_hash("#{salt}--#{string}")
		end

		def make_salt
			secure_hash("#{Time.now.utc}--#{password}")
		end

		def secure_hash(string)
			Digest::SHA2.hexdigest(string)
		end
end
