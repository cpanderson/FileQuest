module FileQuest
  
  class Search
    
    @@slocate_db_path = "/var/lib/slocate/slocate.db" # default on linux root directory
    
    def slocate_db_path=(path)
      @@slocate_db_path = path
    end
    
    def slocate_db_path
      @@slocate_db_path
    end
    
    def initialize(directory, query, options = {})
      @dir = directory
      @query = query
      options.assert_valid_keys(:name_only, :doc, :xls, :pdf, :all)
      @options = options
    end
    
    def dir
      @dir
    end
    
    def query
      @query
    end
    
    def options
      @options
    end
    
    def command
      if RUBY_PLATFORM =~ /darwin/
        @command = "mdfind -onlyin #{dir}"
        @command += ' -name' if @options[:name_only]
        @command += " '#{query}'"
      elsif RUBY_PLATFORM =~ /linux/
        @command = "locate -d '#{@@slocate_db_path}' #{query} | grep -iE '#{dir}.*.(doc|pdf|xls)'"
      end
      @command
    end
    
    def search
      command
      results = %x[#{@command}]
      results.split(/\n/)
    end
    
    private
    
    def spotlight
      
    end
    
    def slocate
      
    end
    
  end
  
end
