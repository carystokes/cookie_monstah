// $(document).ready(function() {
//   debugger;
//   $('.upvote').on('click', function(event) {
//     event.preventDefault();
//
//     let url = this.parentElement.action;
//     debugger;
//     let currentTarget = $(event.currentTarget);
//     let id = parseInt(this.id);
//
//     let request = $.ajax({
//       method: "POST",
//       url: `${url}.json`
//     });
//
//     request.done(function(data) {
//       document.getElementById(`total${id}`).innerHTML = data.vote;
//     })
//   });
//
//   $('.downvote').on('click', function(event) {
//     event.preventDefault();
//
//     let request = $.ajax({
//       method: "POST",
//       url: "/review/id/downvote"
//     });
//
//     request.done()
//   });
// })

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
