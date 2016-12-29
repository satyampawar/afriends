class Translation < ActiveRecord::Base
	def translation_keys
		backend = I18n.backend.backends[0]
		translations = backend.send(:translations)[:en][:assets][:properties]
		translations.each do |t|
			puts t
		end
	end
end
