class User < ActiveRecord::Base
	attr_accessible :nom, :email

	validates_presence_of :nom
	validates_length_of :nom, :maximum => 150
	
	validates_presence_of :email
	validates_format_of :email, :with => /@/

	validates_uniqueness_of :email
end
