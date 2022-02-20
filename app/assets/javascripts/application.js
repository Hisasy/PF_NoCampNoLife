// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require popper
//= require bootstrap-sprockets

//= require rails-ujs
//= require activestorage

//= require jquery
//= require jquery_ujs
//= require_tree .
/*global $*/

// 画像スライダー用
$(document).on('ready', function() {
  $(".full-screen-o").slick({
    centerMode: true,
    centerPadding: '35%',
    dots: true,
    autoplay: true,
    autoplaySpeed: 2000,
    speed: 1000,
    infinite: true,
  });
});


// コメント編集ボタン用
$(function () {
  // $(".js-edit-comment-button").on("click", function () {
  $(document).on("click", ".js-edit-comment-button", function () {
    const commentId = $(this).data('comment-id');
    const commentLabelArea = $('#js-comment-label-' + commentId);
    const commentTextArea = $('#js-textarea-comment-' + commentId);
    const commentButton = $('#js-comment-button-' + commentId);

    commentLabelArea.hide();
    commentTextArea.show();
    commentButton.show();
  });
});

// キャンセルボタンクリック時、コメント編集エリア非表示
$(function () {
  $(document).on("click", ".comment-cancel-button", function () {
    const commentId = $(this).data('cancel-id');
    const commentLabelArea = $('#js-comment-label-' + commentId);
    const commentTextArea = $('#js-textarea-comment-' + commentId);
    const commentButton = $('#js-comment-button-' + commentId);
    const commentError = $('#js-comment-post-error-' + commentId);

    commentLabelArea.show();
    commentTextArea.hide();
    commentButton.hide();
    commentError.hide();
  });
});


// コメント更新ボタン
$(function () {
  $(document).on("click", ".comment-update-button", function () {
    const commentId = $(this).data('update-id');
    const textField = $('#js-textarea-comment-' + commentId);
    const comment_new = textField.val();

    $.ajax({
      url: '/comments/' + commentId,
      type: 'PATCH',
      data: {
        comment: {
          comment: comment_new
        }
      }
    })
    .done(function (data) {
        const commentLabelArea = $('#js-comment-label-' + commentId);
        const commentTextArea = $('#js-textarea-comment-' + commentId);
        const commentButton = $('#js-comment-button-' + commentId);
        const commentError = $('#js-comment-post-error-' + commentId);

        commentLabelArea.show();
        commentLabelArea.text(data.comment);
        commentTextArea.hide();
        commentButton.hide();
        commentError.hide();
      })
  });
});
