class OffersController < ApplicationController
  def interesting
    @offers = Offer.interesting.by_date.includes(:tags, :offer_versions, :comments)
  end

  def hidden
    @offers = Offer.hidden.by_date.includes(:tags, :offer_versions, :comments)
  end

  def hide
    Offer.find(params[:id]).update_attributes(hidden: true)

    head :ok
  end

  def unhide
    Offer.find(params[:id]).update_attributes(hidden: false)

    head :ok
  end

  def versions
    @offer = Offer.find_by(offer_hash: params[:id]) || Offer.find(params[:id])
  end

  def filter
    @offers = Tag.find(params[:tag_id]).offers
  end

  def add_tag
    tag = Tag.find(params[:tag_id])
    offer = Offer.find(params[:id])
    if tag.present?
      offer_tags = offer.tags
      offer_tags << tag unless offer_tags.include?(tag)
    end

    head :ok
    # if params[:back_path]
    #   redirect_to params[:back_path]
    # else
    #   interesting_offers_path
    # end
  end

  def remove_tag
    tag = Tag.find(params[:tag_id])
    offer = Offer.find(params[:id])
    offer.tags.delete(tag) if tag.present?

    head :ok
    # if params[:back_path]
    #   redirect_to params[:back_path]
    # else
    #   interesting_offers_path
    # end
  end

  def add_comment
    offer = Offer.find(params[:id])
    offer.comments.create(content: params[:content])

    head :ok
  end
end
