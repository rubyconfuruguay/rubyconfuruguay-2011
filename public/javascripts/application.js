$(document).ready(function() {
  set_up_google_map_links();
});

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

