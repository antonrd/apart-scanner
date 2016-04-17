class MainController < ApplicationController
  def index
    @scans = Scan.by_date
    @scan_urls = ScanUrl.all
  end

  def fetch
    ParseOffers.new(ScanUrl.find(params[:scan_url_id])).call

    redirect_to main_index_path
  end
end
