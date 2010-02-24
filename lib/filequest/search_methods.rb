module SearchMethods
  
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
    else
      @command = nil
    end
    @command
  end
  
  def search
    if command
      results = %x[#{@command}]
      filepaths = {}
      count = 0
      results.split(/\n/).each do |f|
        filepaths[count] = f if ! File.directory?(f) # only return matching files, not directories
        count += 1
      end
      filepaths
    else
      "Sorry, this only works on Mac OS X or Linux"
    end
  end
  
  def run
    search
  end
  
  private
  
  def spotlight
    
  end
  
  def slocate
    
  end
  
end