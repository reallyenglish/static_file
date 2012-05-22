module StaticFileHelper
  def static_file_url(file)
    file.url(:protocol => request.protocol)
  end
end
