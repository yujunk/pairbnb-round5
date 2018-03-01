document.addEventListener("turbolinks:load", function(){
  var submitButton = document.getElementById("button");

window.listingsXHR = new XMLHttpRequest();

  submitButton.onclick = function(event) {
    
    event.preventDefault();

    window.listingsXHR.abort();

    debugger

    var locationInput = document.getElementById("location");
    var priceInput = document.getElementById("price_per_night");
    var smokingInput = document.getElementById("smoking");
    

    var auth_token = document.querySelector("[name='csrf-token']").content;
    window.listingsXHR.open("POST", "/filter?query="+locationInput.value, true);
    window.listingsXHR.setRequestHeader("X-CSRF-TOKEN", auth_token);
    window.listingsXHR.send()
    
  //   window.listingsXHR.onreadystatechange = function() {
  //     if (this.readystate == 4 && this.status == 200) {
  //       var response = 
  //     }
      
  // }
    }
})