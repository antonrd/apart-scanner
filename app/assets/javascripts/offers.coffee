$ ->
  hide_unhide_offer = (offer_id, action_name) ->
    $.ajax (
      method: 'POST',
      url: '/offers/' + offer_id + '/' + action_name
      success: ->
        $('.offer#offer-' + offer_id).hide(400)
        offers_count = parseInt($('span.offers-count').html())
        $('span.offers-count').html(offers_count - 1)
      error: ->
        alert('Failed to ' + action_name + ' offer')
    )

  remove_tag_from_offer = (tag_label, offer_id, tag_id) ->
    $.ajax (
      method: 'POST'
      url: '/offers/' + offer_id + '/remove_tag'
      data:
        tag_id: tag_id
      success: ->
        tag_label.removeClass('added')
      error: ->
        alert('Failed to remove tag from offer')
    )

  add_tag_to_offer = (tag_label, offer_id, tag_id) ->
    $.ajax (
      method: 'POST'
      url: '/offers/' + offer_id + '/add_tag'
      data:
        tag_id: tag_id
      success: ->
        tag_label.addClass('added')
      error: ->
        alert('Failed to add tag to offer')
    )

  $('a.hide-offer').on("click", ->
    offer_id = $(this).data("offerId")
    hide_unhide_offer(offer_id, 'hide')
  )

  $('a.unhide-offer').on("click", ->
    offer_id = $(this).data("offerId")
    hide_unhide_offer(offer_id, 'unhide')
  )

  $('span.tag').on("click", ->
    if $(this).hasClass('added')
      remove_tag_from_offer($(this), $(this).data('offer-id'), $(this).data('tag-id'))
    else
      add_tag_to_offer($(this), $(this).data('offer-id'), $(this).data('tag-id'))
  )

  $('span.show-comment-form').on("click", ->
    $('#offer-comments-' + $(this).data('offer-id')).toggle()
  )

  $('.offer-add-comment').on("click", ->
    textarea = $(this).prev()
    content = textarea.val()
    offer_id = $(this).data('offer-id')

    $.ajax (
      method: 'POST',
      url: '/offers/' + offer_id + '/add_comment'
      data:
        content: content
      success: ->
        textarea.val("")
        $('#offer-comments-' + offer_id).prepend('<div class=\"offer-comment\">' + content + '</div>')
        $('#offer-comments-' + offer_id).toggle()
      error: ->
        alert('Failed to add comment to offer')
    )
  )
