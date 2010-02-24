class FilesController < ActionController::Base
  
  def index
    if params[:query]
      @query = params[:query]
      new_search = FQSearch.new("/some/path", @query)
      @files = new_search.run
    end
    if @files.size > 0
      Rails.cache.write('file_quest', @files)
    end
  end
  
  def download
    files = Rails.cache.read('file_quest')
    file = files[params[:id].to_i]
    send_file(file, :type => file.extname.gsub(/\./, ""), :filename => file.basename)
  end
  
end