require 'filequest/search_methods'
require 'filequest/string_helpers'

module FileQuest
  
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

class FQSearch < FileQuest::Search  
end