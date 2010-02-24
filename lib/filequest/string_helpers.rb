class String
  def basename
    File.basename(self)
  end
  
  def dirname
    File.dirname(self)
  end
  
  def extname
    File.extname(self)
  end
  
  def file?
    File.file?(self)
  end
  
  def directory?
    File.directory?(self)
  end
  
  def filesize
    File.size(self)
  end
end