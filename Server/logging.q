// relative directory to logging.q
.u.rwd: "/" sv -1_ "/" vs ssr[.z.X 1; "\\"; "/"]

system"l ", .u.rwd, "/authentication.q"

// accessLog: user(symbol), handle(int), hostname(symbol), time(timestamp), ip(symbol), state(symbol- `Granted or `Denied)
accessLog: ([]user:`symbol$(); handle:`int$(); hostname:`symbol$(); time:`s#`timestamp$(); ip:`symbol$(); state:`symbol$())
// openConn: user(symbol), handle (int), time(timestamp)
openConn: ([]user:`symbol$(); handle:`int$(); time:`s#`timestamp$())
// queryLog: user (symbol), handle (int), hostname (symbol), time(timestamp),ip (symbol), query (string), sync (boolean)
queryLog: ([]user:`symbol$(); handle:`int$(); hostname:`symbol$(); time:`s#`timestamp$(); ip:`symbol$(); query:(); sync:`boolean$())

.logging.pw: {[name; pass]
    isGranted: .perm.pw[name; pass];
    `accessLog insert (name; 0Ni; `; .z.p; `; `Denied`Granted isGranted);
    isGranted
 }
.logging.po: {[h]
    userIp: h ".z.a";
    update handle: h, hostname: .Q.host userIp, ip: `$"." sv string "i"$0x0 vs userIp from `accessLog where i = last i;
    `openConn insert (exec last user from accessLog where i = last i; h; .z.p);
 }
.logging.pc: {[h] delete from `openConn where handle=h }
.logging.ps: {
    userInfo: exec last user, last hostname, last ip from accessLog where handle = .z.w, time = max time;
    `queryLog insert (userInfo`user; .z.w; userInfo`hostname; .z.p; userInfo`ip; .Q.s1 x; 0b)
 }
.logging.pg: {
    userInfo: exec last user, last hostname, last ip from accessLog where handle = .z.w, time = max time;
    `queryLog insert (userInfo`user; .z.w; userInfo`hostname; .z.p; userInfo`ip; .Q.s1 x; 1b)
 }

.z.pw: { .logging.pw[x;y] }
.z.po: { .logging.po x }
.z.pc: { .logging.pc x }
.z.ps: { .logging.ps x; value x }
.z.pg: { .logging.pg x; value x }

/
q Server/logging.q Server/Resources/userAuth.txt -p 6000
