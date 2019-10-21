import Date from Date

type Task: void {
    name: string
    startDate : Date
    dueDate : Date
}

// but how would it accomodate the developer







// // import ...
// include "console.iol"

// type commentsMsg:void{
//     .postId: string|int
// }

// type commentsResMsg:void {
//     ._* : any {
//         .name:string
//         .postId:int
//         .id:int
//         .body:string
//         .email:string
//     }
// }

// interface commentIface {
//     RequestResponse: comments(commentsMsg)(commentsResMsg) 
// }

// outputPort jsonPlaceHolder{
//     Location: "socket://jsonplaceholder.typicode.com:80"
//     Protocol: http {
//         .osc.comments.alias = "comments?postId=%{postId}"
//         .osc.comments.method = "GET"
//     }
//     // RequestResponse: comments
//     Interfaces: commentIface
// }

// main{
//     comments@jsonPlaceHolder({.postId=1})(res)
//     println@Console( res )(  )
// }