module Helpers

	def self.media_path(file)
    File.join(File.dirname(File.dirname(__FILE__)), 'space/media', file)
  end

end