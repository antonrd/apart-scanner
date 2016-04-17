class ScansController < ApplicationController
  def interesting_offers
    @scan = Scan.find(params[:id])
    @offers = @scan.offers.interesting
  end

  def hidden_offers
    @scan = Scan.find(params[:id])
    @offers = @scan.offers.hidden
  end

  def hide_offers
    Scan.find(params[:id]).offers.update_all(hidden: true)

    redirect_to main_index_path
  end
end
