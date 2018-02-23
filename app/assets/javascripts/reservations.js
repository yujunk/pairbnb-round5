// import flatpickr from "flatpickr";
// const flatpickr = require("flatpickr");


document.addEventListener('turbolinks:load',function(){

  startDate = document.getElementById("reservation_start_date");
  endDate = document.getElementById("reservation_end_date");

  const fpStartDate = flatpickr(startDate, {});

  const fpEndDate = flatpickr(endDate, {});
  })

//DOMContentLoaded is to call a loaded file from the <header> because the js file had already loaded before going to the reservations View, 




// flatpickr(selectDates, {
//   onOpen: function(selectedDates, dateStr, instance) {

//   }

// })



// flatpickr("#dates", {})
