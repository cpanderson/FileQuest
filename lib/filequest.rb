require 'filequest/search_methods'
require 'filequest/browse_methods'
require 'filequest/helpers'

module FileQuest
  
  class FileItem
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
    
    def file?
      true
    end
    
    def dir?
      false
    end
    
    def type
      "f"
    end
  end
  
  class DirItem
    attr_accessor :id, :path, :dirname, :last_modified
    
    def initialize(id, dir)
      @id = id
      @path = dir
      @dirname = File.basename(dir)
      @last_modified = File.mtime(dir)
    end
    
    def file?
      false
    end
    
    def dir?
      true
    end
    
    def type
      "d"
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
  
  class Browse
    def initialize(directory)
      @base_dir = directory
    end
    
    include BrowseMethods
  end
  
end

# aliases
class FQFileItem < FileQuest::FileItem
end

class FQDirItem < FileQuest::DirItem
end

class FQSearch < FileQuest::Search  
end

class FQBrowse < FileQuest::Browse
end
