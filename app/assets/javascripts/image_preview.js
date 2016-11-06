$(function() {
  onload = function() {
    var input = document.getElementById('file');
    var dst = document.getElementById('dst');
  
    input.onchange = function() {
      // 選択中のファイルの一つ目
      var file = this.files[0];
      // ファイルを選択しなかった場合
      if(!file) return;
      // ファイル形式
      console.log(file.type);
      // ファイル形式の中にimageが含まれない場合
      if(!/image/.test(file.type)) {
        alert('画像を選択してください。');
        return;
      }
  
      // 読み込み用の関数で読み込み完了時に、HTMLにcanvasタグを追加
      load(file, function(canvas) {
        dst.appendChild(canvas);
  
        // canvas がクリックされた時に、別ウィンドウで画像を開く
        canvas.onclick = function() {
          open(this.toDataURL('image/png'));
        };
      });
  
    };
  
    function load(file, callback) {
      // canvas: true にすると canvas に画像を描画する(回転させる場合は必須オプション)
      var options = {canvas: true};
  
      loadImage.parseMetaData(file, function (data) {
        if (data.exif) {
          console.log("exifに格納されている情報:\n", data.exif.getAll());
  
          // options の orientation は小文字。 exif.getの 'Orientation' は先頭大文字
          // ここでcanvasの回転を指定している
          options.orientation = data.exif.get('Orientation');
          console.log('Orientation: ' + options.orientation);
        }
        // 画像の読み込み。完了時に callback が呼び出される
        loadImage(file, callback, options);
      });
    }
  };

  
});