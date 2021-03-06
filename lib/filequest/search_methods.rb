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
      @command = "mdfind -onlyin '#{dir}'"
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
      @results = []
      begin
        timeout(@options[:timeout]) do
          %x[#{@command}].split(/\n/).each do |f|
            if !File.directory?(f) # only return matching files, not directories
              @results << FQFileItem.new(f)
            end
          end
        end
      rescue Timeout::Error
        @results
      end
      @results
    else
      "Sorry, this only works on Mac OS X or Linux"
    end
  end


  def run
    search
  end

  def results
    @results
  end

  private

  def spotlight

  end

  def slocate

  end

end