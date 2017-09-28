$(document).on 'turbolinks:load', ->
  $('body').on 'click', 'a.remove_twit', (e) ->
    $.ajax '/twits/'+ e.target.id,
        type: 'DELETE'
        dataType: 'json',
        data: {}
        success: (data, text, jqXHR) ->
          Materialize.toast('Twit removido', 4000, 'green')
          $('#card_' + e.target.id).remove()
        error: (jqXHR, textStatus, errorThrown) ->
          if errorThrown is 'Forbidden'
            Materialize.toast('Permissão negada', 4000, 'red')
          else
            Materialize.toast('Problema na remoção do Twit', 4000, 'red')
    return false

$(document).on 'turbolinks:load', ->
  $('#post').on 'click', (e) ->
    $.ajax "/twits",
      type: 'POST'
      dataType: 'json',
      data: {
        twit: {
          content: $('textarea').val()
        }
      }
      success: (data, text, jqXHR) ->
        Materialize.toast('Twit Adicionado', 4000, 'green')
        location.reload()
      error: (jqXHR, textStatus, errorThrown) ->
        Materialize.toast('Problema na criação do Twit', 4000, 'red')
    return false


# insert_twit = (id, content) ->
#   $('.card').prepend(
#     '<div class="card" id="card_' + id + '">' +
#         '<div class="card-content">' +
#           '<span class="card-title"> "@" + ' + id + '</span>' +
#             '<p id="content_' + id + '"> ' + content + ' </p>' +
#         '</div>' +
#         '<div class="card-action">' +
#           '<a class="left edit_twit" href="#" id="' + id + '">' +
#             '<i class="material-icons" id="' + id + '">edit</i>' +
#           '</a>' +
#           '<a class="right remove_twit" href="#" id="' + id + '">' +
#             '<i class="material-icons" id="' + id + '">delete</i>' +
#           '</a>' +
#         '</div>' +
#     '</div>')





# $(document).on 'turbolinks:load', ->
#   $('body').on 'submit', '.add_twit', (e) ->
#     $.ajax '/twits',
#         type: 'POST'
#         dataType: 'json',
#         data: {
#           twit: {
#             content: $('#textarea').val()
#           }
#         }
#         success: (data, text, jqXHR) ->
#           Materialize.toast('Twit Adicionado', 4000, 'green')
#         error: (jqXHR, textStatus, errorThrown) ->
#           Materialize.toast('Problema na criação do Twit', 4000, 'red')
#     return false
#
#

















$(document).on 'turbolinks:load', ->
  $('body').on 'click', 'a.edit_twit', (e) ->
    $('#twitcontent').focus()
    $('#twitcontent').val($('#content_' + e.target.id).text())
    return false

# $(document).on 'turbolinks:load', ->
#   $('.update_campaign input').bind 'blur', ->
#     $('.update_campaign').submit()
#
#   $('.update_campaign').on 'submit', (e) ->
#     $.ajax e.target.action,
#         type: 'PUT'
#         dataType: 'json',
#         data: $(".update_campaign").serialize()
#         success: (data, text, jqXHR) ->
#           Materialize.toast('Campanha atualizada', 4000, 'green')
#         error: (jqXHR, textStatus, errorThrown) ->
#           Materialize.toast('Problema na atualização da Campanha', 4000, 'red')
#     return false
