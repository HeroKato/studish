$(function(){
  $('#post_post_pictures_attributes_0_pictures').bind('change', function() {
    var image_number = this.files.length;
    if (image_number > 2) {
      alert('画像は最大で2つまでです。');
      return false;
    }
  });
});