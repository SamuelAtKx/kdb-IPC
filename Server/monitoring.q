// relative directory to monitoring.q
.u.rwd: "/" sv -1_ "/" vs ssr[.z.X 1; "\\"; "/"]

system"l ", .u.rwd, "/logging.q"

// hostname (symbol), port(int), pid (int), handle (int), sendTime(timestamp), responseTime(timestamp)
heartbeats: ([] hostname:`symbol$(); port:`int$(); pid:`int$(); handle:`int$(); sendTime:`timestamp$(); responseTime:`timestamp$())

.heartbeat.callback: { `heartbeats insert x }
.heartbeat.remoteFunc: {[callback; sendTime]
    neg[.z.w] (callback; (.Q.host .z.a; system"p"; .z.i; .z.w; sendTime; .z.p))
 }
.heartbeat.lastTime: 0p
.heartbeat.interval: 00:00:30
.heartbeat.ts: { 
    if[.heartbeat.interval <= (p:.z.p)-.heartbeat.lastTime;
        -25!(key .z.W; (.heartbeat.remoteFunc; `.heartbeat.callback; p));
        .heartbeat.lastTime: p
    ]
 }

.z.ts: { .heartbeat.ts[] }

/
q Server/monitoring.q Server/Resources/userAuth.txt -p 6000 -t 1000
