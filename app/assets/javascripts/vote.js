function upvoteButton() {
  event.preventDefault();
  let id = event.currentTarget.id;

  let request = $.ajax({
    url: `/reviews/${id}/upvote.json`,
    method: "POST"

  });

  request.done(function(data) {
     document.getElementById(`total${id}`).innerHTML = data.total;
   })
 }

 function downvoteButton() {
   event.preventDefault();
   let id = event.currentTarget.id;

   let request = $.ajax({
     url: `/reviews/${id}/downvote.json`,
     method: "POST"

   });

   request.done(function(data) {
      document.getElementById(`total${id}`).innerHTML = data.total;
    })
  }
