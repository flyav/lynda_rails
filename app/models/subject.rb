require 'test'
class Subject < ActiveRecord::Base

	include Test

	has_many :pages

	validates_presence_of :name
	validates_length_of :name, :maximum => 255
	
	scope :visible, ->(boolean) { where(:visible => boolean) }
	scope :search, ->(query) { where(["name LIKE ?", "%#{query}%"])}
	
end
