function upvoteButton() {
  event.preventDefault();
  let forkup = event.currentTarget.id;

  let request = $.ajax({
    url: "reviews/" + forkup + "/upvote.json",
    method: "POST"

  });

  request.done(function(data) {
     document.getElementById(`total${forkdonefirst}`).innerHTML = data.total;
   })
 }

 function downvoteButton() {
   event.preventDefault();
   let forkdown = event.currentTarget.id;

   let request = $.ajax({
     url: `/reviews/${forkdown}/downvote.json`,
     method: "POST"

   });

   request.done(function(data) {
      document.getElementById(`total${forkdone}`).innerHTML = data.total;
    })
  }
