$( document ).on('turbolinks:load', function() {

  $('.artist-select').on('change', function(){
    var params = {artist_id : $(this).val()}
     $.ajax({
      url: "artists/" + params.artist_id,
      method: 'GET',
      dataType: 'json',
      error: function(jqXHR, textStatus, errorThrown){
          console.log("AJAX Error:" +textStatus)
        },
      complete: function(data, textStatus, jqXHR){
        $('.albums-heading .albums-message .artist-albums').empty()
        var artist_data = data.responseJSON
        var albums = artist_data.albums
        if (albums.length > 0) {
          $('.albums-heading').append('<h1>Albums<h1>')
          for(let i = 0; i < albums.length; i++) {
            $('.artist-albums').append('<li><a href="albums/' + albums[i].id + '">' + albums[i].title + '</a></li>')
          }
        } else {
          $('.albums-message').append('<p>This artist currently has no albums.<p>')
        }
      }
    });
  })

});