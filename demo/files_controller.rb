class FilesController < ActionController::Base
  
  def index
    if params[:query]
      @query = params[:query]
      new_search = FQSearch.new("/Documents", @query)
      @files = new_search.run
      Rails.cache.write('file_quest', @files) if @files.size > 0
    end
  end
  
  def download
    files = Rails.cache.read('file_quest')
    file = files[params[:id].to_i]
    send_file(file, :type => file.extname.gsub(/\./, ""), :filename => file.basename)
  end
  
end