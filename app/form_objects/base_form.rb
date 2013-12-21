class BaseForm
	# -- ActiveModel FUNCTIONALITY
	extend ActiveModel::Naming
	include ActiveModel::Conversion
	include ActiveModel::Validations

	def persisted?
		false
	end
	
end