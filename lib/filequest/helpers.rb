module FileQuestHelper
  
  # omit x levels of directory starting from the base
  # ie. fq_omit_dir_levels("/Base/Dir 1/Dir 2/Dir 3", 2) => "/Dir 2/Dir 3"
  def fq_omit_dir_levels(file, levels)
    dirs = file.dirname.split('/')
    fullpath = ""
    dirs[(1 + levels)..dirs.size].each do |d|
      fullpath += "/" + d
    end
    fullpath
  end
  
  # outputs bytes into human readable format
  # ie. fq_readable_size(1000) => "1 KB"
  def fq_readable_size(file, precision = 2)
    number_to_human_size(file.filesize, :precision => precision)
  end
  
end