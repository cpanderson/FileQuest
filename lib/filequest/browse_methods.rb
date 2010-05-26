module BrowseMethods
  
  def base_dir
    @base_dir
  end
  
  def current_dir
    @current_dir
  end
  
  def current_dir=(dir)
    @current_dir = dir
    if @previous_dir == dir # going back
      @trail.pop
      @previous_dir = @trail[@trail.size - 2]
    else # going forward
      @previous_dir = @trail.last
      @trail << dir
    end
  end
  
  def previous_dir
    @previous_dir || @current_dir
  end
  
  def trail
    @trail
  end
  
  def contents
    dir_results = []
    file_results = []
    Dir.entries(current_dir).each do |f|
      if (f =~ /^\./).nil? # ignore hidden files and ./.. directories
        full_path = current_dir + "/" + f
        if File.directory?(full_path)
          dir_results << FQDirItem.new(full_path)
        else
          file_results << FQFileItem.new(full_path)
        end
      end
    end
    dir_results = dir_results.sort!{|a,b| a.type <=> b.type} + file_results.sort!{|a,b| a.filename <=> b.filename}
    if current_dir != base_dir # put in a "previous" directory link
      dir_results.insert(0, FQDirItem.new(previous_dir, :dirname => ".."))
    end
    
    dir_results
  end

end