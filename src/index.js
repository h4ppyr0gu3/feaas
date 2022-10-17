import Router from 'vanilla-router';

var router = new Router({
  mode: 'history',
  page404: function (path) {
    console.log('"/' + path + '" Page not found');
  }
});

router.add('', function () {
  let apklrbsiResponse = ""
  entry = document.getElementById("entry");
  const apklrbsiHeaders = new Headers();
  apklrbsiHeaders.append('auth', 'auth');
  const apklrbsiInit = {
    method: 'GET',
    // headers: apklrbsiHeaders,
    mode: 'cors',
    cache: 'default',
  };
  const apklrbsiRequest = new Request('http://localhost:4567');

  fetch(apklrbsiRequest, apklrbsiInit)
    .then((response) => {
      return response.json();
    }).then((body) => {
      apklrbsiResponse = body;
      console.log(apklrbsiResponse);
      apklrbsiResponse.songs.forEach((song) => {
        entry = document.getElementById("entry");
        var container = document.createElement('div');
        container.classList.add('card');
        var col1 = document.createElement('div');
        col1.classList.add('columns');
        var img = document.createElement('img');
        var text = document.createElement('div');
        text.classList.add("is-size-4");
        text.innerHTML = "something other than text";
        var button = document.createElement('button');
        button.id = "button-" + song.id;
        button.classList.add("button");
        button.innerHTML = "click me";
        console.log(button);
        container.appendChild(img);
        container.appendChild(button);
        container.appendChild(text);
        entry.appendChild(container);
        document.getElementById("button-" + song.id).addEventListener('click', () => {
          event.preventDefault;
          console.log("pressed-" + song.id);
        })
      });
    }).catch(function (err) {
      console.warn('Something went wrong.', err);
    });

  // entry.innerHTML = "<div class='card'>        <div class='columns'><div class='column'> <img src='https://play-lh.googleusercontent.com/V_P-I-UENK93ahkQgOWel8X8yFxjhOOfMAZjxXrqp311Gm_RBtlDXHLQhwFZN8n4aIQ' alt='alt text' /> </div><div class='column'>       <div class='is-size-3 '>       some text in here      </div>       </div><div class='column'>       <button class='button'>       button called      </button>       </div></div>      </div>"
});

// router.add('hello/(:any)', function (name) {
//     console.log('Hello, ' + name);
// });

// router.add('about', function () {
//     console.log('About Page');
//      entry = document.getElementById("entry");
//      entry.innerHTML = "<h1> About me </h1>";
// });

// document.getElementById("about").addEventListener('click', () => {
//   event.preventDefault;
//   router.navigateTo('about');
// })

// document.getElementById("about").addEventListener('click', () => {
//   event.preventDefault;
//   router.navigateTo('about');
// })

document.addEventListener("DOMContentLoaded", () => {
  router.check();
})

window.addEventListener('load', () => {
}); 

