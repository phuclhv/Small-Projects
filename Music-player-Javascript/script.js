const songs = [
  "ChuaBaoGio.mp3",
  "DuaNhauDiTron.mp3",
  "NeuNhuNgayAy.mp3",
  "NgayLangThang.mp3"
]

const createSongList = () => {
    const list = document.createElement('ol')
    let song    
    for (song of songs){
      const item = document.createElement('li')
      item.appendChild(document.createTextNode(song))
      list.appendChild(item)
    }

    return list
}
document.getElementById('songList').appendChild(createSongList())

songList.onclick = (e) =>{
  const clickedItem = e.target
  const source = document.getElementById('source')
  source.src = 'songs/' + clickedItem.innerText
  source.idx = clickedItem.idx
  document.getElementById('currentlyPlayingSong').innerText = "Currently Playing: "
  document.getElementById('currentSong').innerText = clickedItem.innerText
  player.load()
  player.play()
}

const playAudio = () =>{
  const source = document.getElementById('source')
  if (source.src == ""){
    source.src = "songs/" +  songs[0]
    player.load()
  }
  player.play()
  if (player.readyState){
    player.play()
  }
}

const pauseAudio = () => {
  player.pause()
}

const fastForward =() => {
  try{
  player.currentTime += 20
  }
  catch(e){}
}

const nextAudio = () => {
  const source = document.getElementById('source')
  console.log(source.src)  
}

const slider = document.getElementById('volumeSlider')
slider.oninput = (e) =>{
  const volume = e.target.value
  player.volume = volume
}

const updateProgress = () =>{
  const progressBar = document.getElementById('progress')
  if (player.currentTime > 0)
    progressBar.value = (player.currentTime / player.duration) * 100
}


