class FootballPlayerSearch < DbSearch

	def search_class
		FootballPlayer
	end
	
	private
	
	def sort
		direction = @options[:direction] || :desc
		if @options[:sort].present? && validate_attribute(@options[:sort])
			@results = @results.order(@options[:sort] => direction)
		end
	end
	
	def filter
		if @options[:filter].present?
			@results = @results.where("name LIKE ?", "%#{@options[:filter]}%")
		end
	end
	
	
end
