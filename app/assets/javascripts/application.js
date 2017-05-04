// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require jquery.remotipart
//= require private_pub
//= require select2.min
//= require jstree
//= require jstree.min

//= require plugins/jstree/jstree.min
//= require dataTables/jquery.dataTables
//= require jquery.e-calendar
//= require jquery.soulmate
//= require jquery.jstree

//= require turbolinks
//= require bootstrap
//= require gmaps
//= require chat
//= require jquery-fileupload/basic
//= require jquery-fileupload/vendor/tmpl



//= require jquery.contextMenu

//= require user
//= require_tree .



// if ('serviceWorker' in navigator) {
//   console.log('Service Worker is supported');
//   navigator.serviceWorker.register('/assets/plugins/serviceworker.js')
//     .then(function(registration) {
//       console.log('Successfully registered!', '', registration);
//       registration.pushManager.subscribe({ userVisibleOnly: true })
//   .then(function(subscription) {
//     $.post("/subscribe", { subscription: subscription.toJSON() });
//   });
//   }).catch(function(error) {
//     console.log('Registration failed', '', error);
//   });
// }

window.onload = function() {

  // Set the size of the rendered Emojis
  // This can be set to 16x16, 36x36, or 72x72
  twemoji.size = '16x16';

  // Parse the document body and
  // insert <img> tags in place of Unicode Emojis
  twemoji.parse(document.body);
}




$(document).ready(function(){
  $("select").select2({

    templateResult: formatState,
    templateSelection: formatState
  })

  function formatState (opt) {
      if (!opt.id) {
          return opt.text;
      }               
      var optimage = $(opt.element).data('image'); 
      if(!optimage){
          return opt.text;
      } else {                    
          var $opt = $('<span><img src="' + optimage + '" width="23px" /> ' + opt.text + '</span>');
          return $opt;
      }
  };
  var sampleTags = ['c++', 'java', 'php', 'coldfusion', 'javascript', 'asp', 'ruby', 'python', 'c', 'scala', 'groovy', 'haskell', 'perl', 'erlang', 'apl', 'cobol', 'go', 'lua'];
  twemoji.size = '16x16';
  twemoji.parse(document.body);
  $(document).on( 'scroll', function(){
    if ($(window).scrollTop() > 100) {

        $('.scroll-top-wrapper').addClass('show');
    } else {
        $('.scroll-top-wrapper').removeClass('show');
    }
  });
  $('.scroll-top-wrapper').on('click', scrollToTop);
});

function scrollToTop() {
    verticalOffset = typeof(verticalOffset) != 'undefined' ? verticalOffset : 0;
    element = $('body');
    offset = element.offset();
    offsetTop = offset.top;
    $('html, body').animate({scrollTop: offsetTop}, 500, 'linear');
}



function callfriend(sid,rid)
{
	 $.post("/conversations", { sender_id: sid, recipient_id: rid }, function (data) {
    chatBox.chatWith(data.conversation_id);
   });
}
$(function() {
  window.emojiPicker = new EmojiPicker({
    emojiable_selector: '[data-emojiable=true]',
    assetsPath: '/assets/',
    popupButtonClasses: 'fa fa-smile-o'
  });
  window.emojiPicker.discover();
});

    $(function () {
        // Remove Search if user Resets Form or hits Escape!
    	$('body, .navbar-collapse form[role="search"] button[type="reset"]').on('click keyup', function(event) {
    		console.log(event.currentTarget);
    		if (event.which == 27 && $('.navbar-collapse form[role="search"]').hasClass('active') ||
    			$(event.currentTarget).attr('type') == 'reset') {
    			closeSearch();
    		}
    	});

    	function closeSearch() {
        var $form = $('.navbar-collapse form[role="search"].active');
      	$form.find('input').val('');
    		$form.removeClass('active');
    	}

		// Show Search if form is not active // event.preventDefault() is important, this prevents the form from submitting
    	$(document).on('click', '.navbar-collapse form[role="search"]:not(.active) button[type="submit"]', function(event) {
    		event.preventDefault();
    		var $form = $(this).closest('form'),
    			$input = $form.find('input');
    		$form.addClass('active');
    		$input.focus();
    	});
		// ONLY FOR DEMO // Please use $('form').submit(function(event)) to track from submission
		// if your form is ajax remember to call `closeSearch()` to close the search container
    	$(document).on('click', '.navbar-collapse form[role="search"].active button[type="submit"]', function(event) {
    		event.preventDefault();
    		var $form = $(this).closest('form'),
    			$input = $form.find('input');
    		$('#showSearchTerm').text($input.val());
              closeSearch()
    	});
    });




// function get_last_seen()
// {
//   $("chat-panel").html


//   $.ajax({
//     type: "get",
//     url: "feedback.php",
//     async: false
//     })
// }


var ready = function () {
    $(document).on('click', '.toggleChatBox', function (e) {
        e.preventDefault();

        var id = $(this).data('cid');
        chatBox.toggleChatBoxGrowth(id);
    });

    /**
     * Used to close the chatbox
     */

    $(document).on('click', '.closeChat', function (e) {
        e.preventDefault();

        var id = $(this).data('cid');
        chatBox.close(id);
    });


    /**
     * Listen on keypress' in our chat textarea and call the
     * chatInputKey in chat.js for inspection
     */

    $(document).on('keydown', '.chatboxtextarea', function (event) {

        var id = $(this).data('cid');
        chatBox.checkInputKey(event, $(this), id);
    });

    /**
     * When a conversation link is clicked show up the respective
     * conversation chatbox
     */

    $('a.conversation').click(function (e) {
        e.preventDefault();

        var conversation_id = $(this).data('cid');
        chatBox.chatWith(conversation_id);
    });


}

$(document).ready(ready);
$(document).on("page:load", ready);


$(document).ready(function(){
  $("#search").on('keyup',function(){
    var value = this.value
    $.ajax({
      type: "get",
      url: "/search_user",
      data: {search_letter: value}
    })
  });
});




$(document).ready(function()
{
  
  // setInterval(function(){get_last_seen();}, 10000);


  $("#notificationLink").click(function()
  {
  $("#notificationContainer").fadeToggle(300);
  $("#notification_count").fadeOut("slow");
  return false;
  });

  $(document).click(function()
  {
  $("#notificationContainer").hide();
  });
  //Popup Click


});


