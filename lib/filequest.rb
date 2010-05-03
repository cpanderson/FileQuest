require 'filequest/search_methods'
require 'filequest/helpers'

module FileQuest
  
  class Item
    attr_accessor :id, :path, :dirname, :filename, :extension, :filetype, :filesize, :last_modified

    def initialize(id, file)
      @id = id
      @path = file
      @dirname = File.dirname(file)
      @filename = File.basename(file)
      @extension = File.extname(file)
      @filetype = File.extname(file).gsub(/\./, "")
      @filesize = File.size(file)
      @last_modified = File.mtime(file)
    end
  end
  
  class Search
    class_inheritable_accessor :slocate_db_path, :name_only_default
    
    self.slocate_db_path = "/var/lib/slocate/slocate.db"
    self.name_only_default = true
    
    def initialize(directory, query, options = {:name_only => self.name_only_default})
      @dir = directory
      @query = query
      options.assert_valid_keys(:name_only)
      @options = options
    end
  
    include SearchMethods
  end
  
end

# aliases
class FQItem < FileQuest::Item
end

class FQSearch < FileQuest::Search  
end