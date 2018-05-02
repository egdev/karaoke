class Song < ApplicationRecord
	has_and_belongs_to_many :singers
	
  validates :title, presence: true
  
	def self.import
    source_dir = "/mnt/d/Karaoké A jour sept 2015" 
    i = 0
    Dir.entries(source_dir).each do |d|
      next if d == "." || d == ".."
      singer = Singer.find_by_name(d)
      if singer.nil?
        singer = Singer.new
        singer.name = d
        singer.save
      end
      
      Dir.glob(source_dir + "/" + d + "/**/*.kfn").each do |file|
        filename = File.basename(file, File.extname(file))
        md5 = Digest::MD5.file(file).hexdigest
        
        song = Song.find_by_checksum(md5)
        if song.nil?
          song = Song.new
          song.singers << singer
          song.title = filename
          song.checksum = md5
          song.full_path = file
          song.save
        end
      end
      
      #break if i > 50
      i += 1
    end
	end
  
end
