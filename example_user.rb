class User
	#This creates “getter” and “setter” methods that allow us to retrieve (get) and assign (set) @name and @email instance variables, which were mentioned briefly in Section 2.2.2 and Section 3.4.2.1.
	attr_accessor :name, :email

	#Initialize is special in Ruby: it’s the method called when we execute User.new.
	def initialize(attributes = {})
		@name = attributes[:name]
		@email = attributes[:email]
	end

	#Our class defines a method called formatted_email that uses the values of the assigned @name and @email variables to build up a nicely formatted version of the user’s email address using string interpolation
	def formatted_email
		#instance variables (as indicated with the @ sign)
		"#{@name}, #{@email}"
	end
end


