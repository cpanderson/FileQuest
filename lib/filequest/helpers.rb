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
  
  # truncate long directory names with a pop-up to get full directory
  # ie. fq_truncate_dir("/some/long/directory", 5) => "/some...(full)"
  def fq_truncate_dir(dir, chars)
    omission = "...(<a href='#' title='#{dir}'>full</a>)"
    length = chars - omission.gsub(/<\/?[^>]*>/, "").chars.count # count without html
    dir.chars.count > chars ? dir[/\A.{#{length}}\w*\;?/m][/.*[\w\;]/m] + omission : dir
  end
  
  # show the appropriate file/directory icon
  def fq_show_icon(item)
    if item.file?
      image = "fq_icons/" + item.filetype + ".png"
      if File.exists?(Rails.public_path + "/images/" + image)
        image_tag(image)
      else
        image_tag("fq_icons/_blank.png")
      end
    elsif item.dir?
      image_tag("fq_icons/folder.png")
    end
  end
    
end