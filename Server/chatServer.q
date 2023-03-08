// relative directory to logging.q
.u.rwd: "/" sv -1_ "/" vs ssr[.z.X 1; "\\"; "/"]

system"l ", .u.rwd, "/monitoring.q"

.chat.SendMsg: {[username; msg]
    $[username in `all, users:.chat.GetUsers[];
        username: users except exec first user from openConn where handle=.z.w;
        neg[.z.w] "'`$", "\".chat.SendMsg: user does not exist - ",(string username),"\""
    ];
    if[0 > type username; username: enlist username];
    (exec neg handle from openConn where user in username) @\: (0N!; msg)
 }
.chat.GetUsers: {[] exec user from openConn }

.server.RemoteRaiseError: {[h; msg] neg[h] "'`$", msg }

.server.pw: {[user;pass]
    if[not user in exec username from .perm.auth;
        .perm.Add[user;pass]
    ];
    .logging.pw[user;pass]
 }
.server.po: {[h]
    .logging.po h;
    .chat.SendMsg[`all; "User ",(string exec first user from openConn where handle=h)," has joined the chat"]
 }
// all the functions defined that users are allowed to use
.server.func: raze(system"f"),{`$(x,".") ,/: string system"f ",x} @/: "." ,/: string (key`) except `q`Q`h`j`o`server
.server.isValidQuery: {
    if[(100h~type first x) and 0h~type x;
        .server.RemoteRaiseError[.z.w; "\".server.ps: function call is not allowed - ",(string x 0),"\""]; 
        :0b
    ];
    if[10h~type x; x: parse x];
    if[not x[0] in .server.func; 
        .server.RemoteRaiseError[.z.w; "\".server.ps: function call is not allowed - ",(string x 0),"\""]; 
        :0b
    ];
    1b
 }
.server.ps: {
    isValidQuery: .server.isValidQuery x;
    if[isValidQuery; .logging.ps x];
    isValidQuery
 }
.server.pg: {
    isValidQuery: .server.isValidQuery x;
    if[isValidQuery; .logging.pg x];
    isValidQuery
 }

.z.pw: { .server.pw[x;y] }
.z.po: { .server.po x }
.z.ps: { if[.server.ps x; :value x] }
.z.pg: { if[.server.pg x; :value x] }

/
q Server/chatServer.q Server/Resources/userAuth.txt -p 6000 -t 1000 -e 1 -g 1

system "ping 127.0.0.1 -n 30 > nul";