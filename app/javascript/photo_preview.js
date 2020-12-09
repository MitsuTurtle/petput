document.addEventListener('DOMContentLoaded', function( ){
  const ImageList = document.getElementById('image-list');
  document.getElementById('file-button').addEventListener('change', function(e){
    const file = e.target.files[0];
    const blob = window.URL.createObjectURL(file);

    // 画像を表示するためのdiv要素を生成
    const imageElement = document.createElement('div')

    // 表示する画像を生成
    const blobImage = document.createElement('img');
    blobImage.setAttribute('src', blob);
    blobImage.setAttribute('class', "preview-img");

    // 生成したHTMLの要素をブラウザに表示させる
    imageElement.appendChild(blobImage);
    ImageList.appendChild(imageElement);
  });
});