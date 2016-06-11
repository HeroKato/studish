$(function(){
    $('a[href^=#]').click(function(){ 
        var speed = 1500; //移動完了までの時間(sec)を指定
        var href= $(this).attr("href"); 
        var target = $(href == "#" || href == "" ? 'html' : href);
        var position = target.offset().top - 60;
        $("html, body").animate({scrollTop:position}, speed, "swing");
        return false;
    });
    
});