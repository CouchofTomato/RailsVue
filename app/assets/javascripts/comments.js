$('input[type="submit"]').click(function(e) {
    e.preventDefault();
    $.ajax({
  	url:  window.location.href() + $( ‘#new_comment’ ).attr( 'action' ),
 	method: “PUT”,
 	data: (“#new_comment” ).serialize(),
        },
        success: function(result) {
            alert('ok');
        },
        error: function(result) {
            alert('error');
        }
    });
});