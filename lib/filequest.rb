module FileQuest
  
  class Search
    
    def initialize(directory, query, options = {})
      @dir = directory
      @query = query
      options.assert_valid_keys(:name, :doc, :xls, :pdf, :all)
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
        @command += ' -name "' + query + '"' if @options[:name]
        @command += " " + query if ! @options[:name_only]
      elsif RUBY_PLATFORM =~ /linux/
        #@command = 'locate ' + query + " | grep " + dir
        @command = 'locate -d /mnt/merserv/var/lib/slocate/slocate.db ' + query + " | grep -iE '" + dir + ".*\.(doc|pdf|xls)'"
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
