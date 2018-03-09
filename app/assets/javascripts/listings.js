document.addEventListener("turbolinks:load", function(){
  var submitButton = document.getElementById("button");

window.listingsXHR = new XMLHttpRequest();

  submitButton.onclick = function(event) {
    
    event.preventDefault();

    window.listingsXHR.abort();

    var locationInput = document.getElementById("location");
    var priceInput = document.getElementById("price_per_night");
    var smokingInput = document.getElementById("smoking");

    var auth_token = document.querySelector("[name='csrf-token']").content;

    window.listingsXHR.open("POST", "/filter?location="+locationInput.value + "&price_per_night=" + priceInput.value + "&smoking=" + smokingInput.value, true);
    window.listingsXHR.setRequestHeader("X-CSRF-TOKEN", auth_token);
    window.listingsXHR.send();
    var list = document.getElementById("list");

    window.listingsXHR.onreadystatechange = function() {
      if (this.readyState == 4 && this.status == 200) {
        debugger
        var response = JSON.parse(this.responseText)
        
        list.innerHTML = ""

        response.forEach(function(element) {
          var row = document.createElement("tr");
          var cell = document.createElement("td");

          row.appendChild(cell)
        })
      } 
    }
    
    // window.listingsXHR.onreadystatechange = function() {
    //   if (this.readystate == 4 && this.status == 200) {
    //     var
    //   }
      
  }
    
})