require 'pry'

class Array
	def where(hash = {})
		key = hash.keys.first
		val = hash[key]
		matches = []
		
		self.each do |ele|
			if val.class == Regexp
				if ele[key] && ele[key].match(val)
					matches << ele
				end
			else
				if ele[key] == val
					matches << ele
				end
			end
		end
		return matches
	end
end