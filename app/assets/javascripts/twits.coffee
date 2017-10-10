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
    $('#post').on 'click', ->
      $.ajax "/twits",
        type: 'POST'
        dataType: 'json',
        data: {
          twit: {
            content: $('textarea').val()
          }

        }
        success: (data, text, jqXHR) ->
          insert_twit(data['id'], data['content'], data['user']['username'])
          Materialize.toast('Twit Adicionado', 4000, 'green')
        error: (jqXHR, textStatus, errorThrown) ->
          Materialize.toast('Twit incorreto', 4000, 'red')
      return false

insert_twit = (id, content, username) ->
  $('#twit_list').prepend(
    '<div class="card" id="card_' + id + '">' +
        '<div class="card-content">' +
          '<div class="row">' +
            '<span class="col s6 m6 l6 card-title"> @' + username + '</span>' +
            '<span class="col s6 m6 l6 right-align" id="time_' + id + '">' + 'Just Now' + '</span>' +
          '</div>' +
          '<p id="content_' + id + '"> ' + content + ' </p>' +
        '</div>' +
        '<div class="card-action">' +
          '<a class="left edit_twit" href="#" id="' + id + '">' +
            '<i class="material-icons pencil" id="' + id + '">edit</i>' +
          '</a>' +
          '<a class="right remove_twit" href="#" id="' + id + '">' +
            '<i class="material-icons trash" id="' + id + '">delete</i>' +
          '</a>' +
        '</div>' +
    '</div>')

$(document).on 'turbolinks:load', ->
  $('body').on 'click', 'a.edit_twit', (e) ->
    $('#content_' + e.target.id).replaceWith('<textarea id="content_' + e.target.id + '">' + $('#content_' + e.target.id).text() + '</textarea>')
    text = $('#content_' + e.target.id).val()
    $('#content_' + e.target.id).focus().val('').val(text)
    $('#content_' + e.target.id).on 'keypress blur', (a) ->
      if a.which == 13 && a.shiftKey == false || a.type == 'blur'
        $.ajax "/twits/" + e.target.id,
        type: 'PUT'
        dataType: 'json',
        data: {
          twit: {
            content: $('#content_' + e.target.id).val()
          }
        }
        success: (data, text, jqXHR) ->
          time = $('#time_' + data['id']).text()
          replace_twit(data['id'], data['content'], time, data['user']['username'])
          Materialize.toast('Twit atualizado', 4000, 'green')
        error: (jqXHR, textStatus, errorThrown) ->
          console.log(errorThrown)
          Materialize.toast('Problema na hora de atualizar o Twit', 4000, 'red')
    return false

replace_twit = (id, content, created, username) ->
  $('#card_' + id).replaceWith(
    '<div class="card" id="card_' + id + '">' +
        '<div class="card-content">' +
          '<div class="row">' +
            '<span class="col s6 m6 l6 card-title"> @' + username + '</span>' +
            '<span class="col s6 m6 l6 right-align" id="time_' + id + '">' + created + '</span>' +
          '</div>' +
          '<p id="content_' + id + '"> ' + content + ' </p>' +
        '</div>' +
        '<div class="card-action">' +
          '<a class="left edit_twit" href="#" id="' + id + '">' +
            '<i class="material-icons pencil" id="' + id + '">edit</i>' +
          '</a>' +
          '<a class="right remove_twit" href="#" id="' + id + '">' +
            '<i class="material-icons trash" id="' + id + '">delete</i>' +
          '</a>' +
        '</div>' +
    '</div>')
