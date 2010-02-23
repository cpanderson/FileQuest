module FileQuest
  
  class Search
    
    @@slocate_db_path = "/var/lib/slocate/slocate.db" # default on linux root directory

    @@name_only_default = true
    
    def fq_slocate_db_path=(path)
      @@slocate_db_path = path
    end
    
    def fq_slocate_db_path
      @@slocate_db_path
    end
    
    def fq_name_only_default=(default)
      @@name_only_default = default
    end
    
    def fq_name_only_default
      @@name_only_default
    end
    
    def initialize(directory, query, options = {:name_only => @@name_only_default})
      @dir = directory
      @query = query
      options.assert_valid_keys(:name_only)
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
        @command = "locate -d '#{@@slocate_db_path}' #{query} | grep -iE '#{dir}'"
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
