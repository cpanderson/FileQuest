module BrowseMethods
  
  def base_dir
    @base_dir
  end
  
  def current_dir
    @current_dir || @base_dir
  end
  
  def contents
    dir_results = []
    file_results = []
    count = 0
    Dir.entries(current_dir).each do |f|
      if (f =~ /^\./).nil? # ignore hidden files and ./.. directories
        full_path = current_dir + "/" + f
        if File.directory?(full_path)
          dir_results << FQDirItem.new(count, full_path)
        else
          file_results << FQFileItem.new(count, full_path)
        end
        count += 1
      end
    end
    dir_results.sort!{|a,b| a.type <=> b.type} + file_results.sort!{|a,b| a.filename <=> b.filename}
  end

end