class DbSearch
	
	MAX_RESULT_NUMBER = 200
	DEFAULT_RESULT_NUMBER = 30
	SEARCH_SUFFIX = "_sortable_field"

	def search_class
		raise "missing class"
	end
	
	def initialize(options = nil)
		@options = options || {}
	end
	
	def search
		@results = search_class
		apply_pagination
		sort
		filter
		@results.all
	end
	
	private
	
	def apply_pagination
		if @options["per_page"].nil? 
		  @options["per_page"] = DEFAULT_RESULT_NUMBER
		elsif @options["per_page"].to_i > MAX_RESULT_NUMBER
		  @options["per_page"] = MAX_RESULT_NUMBER
		end
		@options["page"] ||= 1
		@results = @results.paginate(per_page: @options["per_page"], page: @options["page"])
	end
	
	def use_for_sort(attribute)
		if search_class.attribute_names.include?(attribute + SEARCH_SUFFIX)  
		  attribute + SEARCH_SUFFIX
		else
		  attribute
		end
	end
	
	def filter
		#no default filter
	end
	
	def sort
		#no default rule for order
	end
	
	def validate_attribute(symbol)
		search_class.attribute_names.include?(symbol.to_s)
	end
end
