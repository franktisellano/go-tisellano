class Link
	@@all = []
	attr_accessor :name, :url
	LINKS_DIR = './links/'

	def initialize(name, url)
		@name = name
		@url = url
	end

	def save
		unless File.file?(LINKS_DIR + slug)
			File.open(LINKS_DIR + slug, 'w') {|f| f.write(@url) }
		end
	end

	def slug
		slug = @name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')

		bad_chars = [ '/', '\\', '?', '%', '*', ':', '|', '"', '<', '>', '.', ' ' ]
		bad_chars.each do |bad_char|
			slug.gsub!(bad_char, '_')
		end

		slug
	end

	def self.find name
		if File.file?(LINKS_DIR + name)
			url = File.open(LINKS_DIR + name).read
			return Link.new(name, url)
		else
			return false
		end
	end

	def self.all
		@@all = []
		Dir.foreach(LINKS_DIR) do |filename|
			next if filename == '.' || filename == '..' || filename == '.DS_Store'
			url = File.open(LINKS_DIR + filename).read
			@@all << Link.new(filename, url)
		end

		@@all
	end

	def self.count
		@@all.count
	end
end