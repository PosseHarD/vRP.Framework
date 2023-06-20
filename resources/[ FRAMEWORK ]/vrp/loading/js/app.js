// From cfx-keks (https://github.com/citizenfx/cfx-server-data/tree/master/resources/%5Btest%5D/keks)
$(document).ready(function(){

var play = false;
var myAudio = document.getElementById("statusAudio");

myAudio.volume = 0.9;
function onKeyDown(event) {
	switch (event.keyCode) {
		case 32:
			if (play) {
				myAudio.pause();
				play = false;
			} else {
				myAudio.play();
				play = true;
			}
			break;
	}
  return false;
}

window.addEventListener("keydown", onKeyDown, false);

document.addEventListener('keypress', (event) => {
  if(event.key == "p") {
      if(myAudio.paused) {
          myAudio.play();
      }else{
          myAudio.pause();
      }
  }else if(event.key == "s") {
      myAudio.volume = myAudio.volume-0.1;
  }else if(event.key == "w") {
      myAudio.volume = myAudio.volume+0.1;
  }
});

var count = 0;
var thisCount = 0;

 $("#js-rotating").Morphext({
	separator: ";",
	speed: "7000",
	animation: "fadeIn",
 });

 const handlers = {
	startInitFunctionOrder(data) {
		count = data.count;
	},
	initFunctionInvoking(data) {
		document.querySelector('.progress-bar').style.left = '0%';
		document.querySelector('.progress-bar').style.width = ((data.idx / count) * 100) + '%';
	},
	startDataFileEntries(data) {
		count = data.count;
	},
	performMapLoadFunction(data) {
		++thisCount;
		document.querySelector('.progress-bar').style.left = '0%';
		document.querySelector('.progress-bar').style.width = ((thisCount / count) * 100) + '%';
	},
};
	window.addEventListener('message', function (e) {
		(handlers[e.data.eventName] || function () { })(e.data);
	});
});