function upvoteButton() {
  event.preventDefault();
  let FORK = event.currentTarget.FORK;

  let request = $.ajax({
    url: `/reviews/${FORK}/upvote.json`,
    method: "POST"

  });

  request.done(function(data) {
     document.getElementById(`total${FORK}`).innerHTML = data.total;
   })
 }

 function downvoteButton() {
   event.preventDefault();
   let FORK = event.currentTarget.FORK;

   let request = $.ajax({
     url: `/reviews/${FORK}/downvote.json`,
     method: "POST"

   });

   request.done(function(data) {
      document.getElementById(`total${FORK}`).innerHTML = data.total;
    })
  }
