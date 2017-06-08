module Helpers

	def media_path(file)
    File.join(File.dirname(File.dirname(__FILE__)), 'media', file)
  end

end