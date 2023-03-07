// relative directory to logging.q
.u.rwd: "/" sv -1_ "/" vs ssr[.z.X 1; "\\"; "/"]

system"l ", .u.rwd, "/authentication.q"

// accessLog: user(symbol), handle(int), hostname(symbol), time(timestamp), ip(symbol), state(symbol- `Granted or `Denied)
accessLog: ([]user:`symbol$(); handle:`int$(); hostname:`symbol$(); time:`s#`timestamp$(); ip:`symbol$(); state:`symbol$())
// openConn: user(symbol), handle (int), time(timestamp)
openConn: ([]user:`symbol$(); handle:`int$(); time:`s#`timestamp$())
// queryLog: user (symbol), handle (int), hostname (symbol), time(timestamp),ip (symbol), query (string), sync (boolean)
queryLog: ([]user:`symbol$(); handle:`int$(); hostname:`symbol$(); time:`s#`timestamp$(); ip:`symbol$(); query:(); sync:`boolean$())

.tmp.pw: .z.pw
.z.pw: {[name; pass]
    isGranted: .tmp.pw[name; pass];
    `accessLog insert (name; 0Ni; `; .z.p; `; `Denied`Granted isGranted);
    isGranted
 }
.z.po: {[h] 
    userIp: h ".z.a";
    update handle: h, hostname: .Q.host userIp, ip: `$"." sv string "i"$0x0 vs userIp from `accessLog where i = last i;
    `openConn insert (exec last user from accessLog where i = last i; h; .z.p);
 }
.z.pc: {[h] delete from `openConn where handle=h }

.z.ps: {
    userInfo: exec last user, last hostname, last ip from accessLog where handle = .z.w, time = max time;
    `queryLog insert (userInfo`user; .z.w; userInfo`hostname; .z.p; userInfo`ip; x; 0b);
    value x
 }
.z.pg: {
    userInfo: exec last user, last hostname, last ip from accessLog where handle = .z.w, time = max time;
    `queryLog insert (userInfo`user; .z.w; userInfo`hostname; .z.p; userInfo`ip; .Q.s1 x; 1b);
    value x
 }

/
q Server/logging.q Server/Resources/userAuth.txt -p 6000
