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
//= require jquery.e-calendar
//= require jquery.soulmate
//= require jquery.jstree

//= require jquery-fileupload/basic
//= require jquery-fileupload/vendor/tmpl
//= require jstree.min
//= require jstree
//= require select2.min
//= require turbolinks
//= require bootstrap
//= require private_pub
//= require jquery.contextMenu
//= require gmaps



//= require chat
//= require user

//= require_tree .
// $(document).keydown(function(e){
//     if(e.which === 123){
//        return false;
//     }
// });
// $(function(){

// $('img').bind('contextmenu', function(e){
// return false;
// }); 

// 	  $("#formData1").submit(function(){
//  $.ajax
//  ({
//     method : "post",
//     url :  $('#formData1').attr("action"),
//     contentType: false,               
// 	processData: false, 
//     data:   new FormData(this),
//  })

// });

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
          var $opt = $(
              '<span><img src="' + optimage + '" width="23px" /> ' + opt.text + '</span>'
          );
          return $opt;
      }

  };
   var sampleTags = ['c++', 'java', 'php', 'coldfusion', 'javascript', 'asp', 'ruby', 'python', 'c', 'scala', 'groovy', 'haskell', 'perl', 'erlang', 'apl', 'cobol', 'go', 'lua'];
   
    twemoji.size = '16x16';

  // Parse the document body and
  // insert <img> tags in place of Unicode Emojis
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

      // Initializes and creates emoji set from sprite sheet
      window.emojiPicker = new EmojiPicker({
        emojiable_selector: '[data-emojiable=true]',
        assetsPath: '/assets/',
        popupButtonClasses: 'fa fa-smile-o'
      });
      // Finds all elements with `emojiable_selector` and converts them to rich emoji input fields
      // You may want to delay this step if you have dynamically created input fields that appear later in the loading process
      // It can be called as many times as necessary; previously converted input fields will not be converted again
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
            var $form = $('.navbar-collapse form[role="search"].active')
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



$(document).ready(function()
{
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



var ready = function () {

    /**
     * When the send message link on our home page is clicked
     * send an ajax request to our rails app with the sender_id and
     * recipient_id
     */

    // $('.start-conversation').click(function (e) {
    //     e.preventDefault();
    //     var recipient_id = $(this).data('rip');
    //     var sender_id = $(this).data('sid');
    


    //     $.post("/conversations", { sender_id: sender_id, recipient_id: recipient_id }, function (data) {
    //         chatBox.chatWith(data.conversation_id);
    //     });
    // });

    /**
     * Used to minimize the chatbox
     */

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