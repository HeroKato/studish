$(function() {
  $("#coach-stream .coach-stream-container").infinitescroll({
      loading: {
        img:     "http://www.mytreedb.com/uploads/mytreedb/loader/ajax_loader_blue_48.gif",
        msgText: "loading..."
      },
      navSelector: "nav.pagination",
      nextSelector: "nav.pagination a[rel=next]",
      itemSelector: "#coach-stream div.coach-stream-item" /* このDOMに差し掛かった時に、次のページのロードが始まる*/
  });
});

$(function() {
  $("#report-stream .report-stream-container").infinitescroll({
      loading: {
        img:     "http://www.mytreedb.com/uploads/mytreedb/loader/ajax_loader_blue_48.gif",
        msgText: "loading..."
      },
      navSelector: "nav.pagination",
      nextSelector: "nav.pagination a[rel=next]",
      itemSelector: "#report-stream div.report-stream-item" /* このDOMに差し掛かった時に、次のページのロードが始まる*/
  });
});

$(function() {
  $("#post-stream .post-stream-container").infinitescroll({
      loading: {
        img:     "http://www.mytreedb.com/uploads/mytreedb/loader/ajax_loader_blue_48.gif",
        msgText: "loading..."
      },
      navSelector: "nav.pagination",
      nextSelector: "nav.pagination a[rel=next]",
      itemSelector: "#post-stream li.post-stream-item" /* このDOMに差し掛かった時に、次のページのロードが始まる*/
  });
});

$(function() {
  $("#comment-stream .comment-stream-container").infinitescroll({
      loading: {
        img:     "http://www.mytreedb.com/uploads/mytreedb/loader/ajax_loader_blue_48.gif",
        msgText: "loading..."
      },
      navSelector: "nav.pagination",
      nextSelector: "nav.pagination a[rel=next]",
      itemSelector: "#comment-stream div.comment-stream-item" /* このDOMに差し掛かった時に、次のページのロードが始まる*/
  });
});

$(function() {
  $("#notification-stream .notification-stream-container").infinitescroll({
      loading: {
        img:     "http://www.mytreedb.com/uploads/mytreedb/loader/ajax_loader_blue_48.gif",
        msgText: "loading..."
      },
      navSelector: "nav.pagination",
      nextSelector: "nav.pagination a[rel=next]",
      itemSelector: "#notification-stream div.notification-stream-item" /* このDOMに差し掛かった時に、次のページのロードが始まる*/
  });
});

$(function() {
  $("#favorite-stream .favorite-stream-container").infinitescroll({
      loading: {
        img:     "http://www.mytreedb.com/uploads/mytreedb/loader/ajax_loader_blue_48.gif",
        msgText: "loading..."
      },
      navSelector: "nav.pagination",
      nextSelector: "nav.pagination a[rel=next]",
      itemSelector: "#favorite-stream li.favorite-stream-item" /* このDOMに差し掛かった時に、次のページのロードが始まる*/
  });
});

$(function() {
  $("#post-comments-stream .post-comments-stream-container").infinitescroll({
      loading: {
        img:     "http://www.mytreedb.com/uploads/mytreedb/loader/ajax_loader_blue_48.gif",
        msgText: "loading..."
      },
      navSelector: "nav.pagination",
      nextSelector: "nav.pagination a[rel=next]",
      itemSelector: "#post-comments-stream li.post-comments-stream-item" /* このDOMに差し掛かった時に、次のページのロードが始まる*/
  });
});

$(function() {
  $("#coach-post-comments-stream .coach-post-comments-stream-container").infinitescroll({
      loading: {
        img:     "http://www.mytreedb.com/uploads/mytreedb/loader/ajax_loader_blue_48.gif",
        msgText: "loading..."
      },
      navSelector: "nav.pagination",
      nextSelector: "nav.pagination a[rel=next]",
      itemSelector: "#coach-post-comments-stream li.coach-post-comments-stream-item" /* このDOMに差し掛かった時に、次のページのロードが始まる*/
  });
});

$(function() {
  $("#answers-stream .answers-stream-container").infinitescroll({
      loading: {
        img:     "http://www.mytreedb.com/uploads/mytreedb/loader/ajax_loader_blue_48.gif",
        msgText: "loading..."
      },
      navSelector: "nav.pagination",
      nextSelector: "nav.pagination a[rel=next]",
      itemSelector: "#answers-stream li.answers-stream-item" /* このDOMに差し掛かった時に、次のページのロードが始まる*/
  });
});