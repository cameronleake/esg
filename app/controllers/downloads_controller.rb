class DownloadsController < ApplicationController

  def resource_download
    @download = Download.find_by_download_token(params[:download_token])
    if @download.expiry_time > Time.now
      send_file @download.resource.file.path, :type => 'application/pdf', :filename => @download.resource.name
      # send_file @download.download.path, :type => 'application/pdf', :filename => @download.resource.name
      # redirect_to categories_path, notice: "Download started.."
    else
      redirect_to categories_path, :alert => "Download link has expired!"
    end
  end

end
