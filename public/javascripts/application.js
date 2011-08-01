$(document).ready(function() {
  set_up_google_map_links();
  start_flickr_gallery();
  set_up_google_forms();
});

function rand(from, to){
  return Math.floor(Math.random() * (to - from + 1) + from);
}

function start_flickr_gallery() {
  sets = [ "72157625144792905", "72157625281695530" ]
  $("#gallery").galleria({
    extend: function(options){
      this.bind('image', function(e) {
        $(e.imageTarget).click(this.proxy(function() {
          this.openLightbox();
        }));
        random_number = rand(-7, 7)
        $(e.imageTarget).rotate({animateTo: random_number})
      })
    },
    showInfo: false,
    showCounter: false,
    thumbnails: false,
    flickr: 'set:' + sets[rand(0, 1)],
    height: 400,
    flickrOptions: {
      thumbSize: 'big',
      sort: 'date-posted-asc'
    }
  });
}

function set_up_google_map_links() {
  $('a.link-to-google-map').click( function(element) {
    show_map_on_the_iframe(this);
    return false;
  });
}

function show_map_on_the_iframe(link) {
  $('div.map iframe').attr('src', $(link).attr('href') + '&output=embed');
  if(window.location.hash != '') {
    window.location = window.location.href.replace(window.location.hash, '#map');
  } else {
    window.location = window.location.href + '#map';
  }
}


function set_up_google_forms() {
  $('form.google').each(function(){
    var id = 'frame_' + (new Date()).getTime();
    $(this).after('<iframe id="'+id+'"></iframe>');
    $("#"+id).hide();
    $(this).attr('target', id);
    $(this).siblings('.success-message').hide();
    $(this).submit(function(){
      $(this).hide();
      $(this).siblings('.success-message').show();
    })
  });

}
