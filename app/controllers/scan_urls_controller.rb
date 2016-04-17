class ScanUrlsController < ApplicationController
  def index
    @scan_urls = ScanUrl.all
  end

  def create
    ScanUrl.create(scan_url_params)

    redirect_to scan_urls_path
  end

  def update
    ScanUrl.find(params[:id]).update_attributes(scan_url_params)

    redirect_to scan_urls_path
  end

  def destroy
    ScanUrl.find(params[:id]).destroy

    redirect_to scan_urls_path
  end

  private

  def scan_url_params
    params.require(:scan_url).permit(:name, :url, :url_suffix)
  end
end
