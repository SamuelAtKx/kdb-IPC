/q logging.q

// change directory to Server
system"cd ", "/" sv -1_ "/" vs ssr[.z.X 1; "\\"; "/"]

\l authentication.q
\p 6000

// queryLog: user (symbol), handle (int), hostname (symbol), time(timestamp),ip (symbol), query (string), sync (boolean)
querylog: ([]user:`symbol$(); handle:`int$(); hostname:`symbol$(); time:`timestamp$(); ip:`symbol$(); query:(); sync:`boolean$())
// accessLog: user(symbol), handle(int), hostname(symbol), time(timestamp), ip(symbol), state(symbol- `Granted or `Denied)
accessLog: ([]user:`symbol$(); handle:`int$(); hostname:`symbol$(); time:`timestamp$(); ip:`symbol$(); state:`symbol$())
// openConn: user(symbol), handle (int), time(timestamp)
openConn: ([]user:`symbol$(); handle:`int$(); time:`timestamp$())

.z.po: {}
.z.pc: {}
.z.ps: { value x }
.z.pg: { value x }
