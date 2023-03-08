
.server.address: `:localhost:6000
.chat.h: 0Ni
.chat.checkConnection: {
    if[null .chat.h; '`$"No connection to the server. Please use .chat.Joins to connect first."]
 }
.chat.Joins: {[user; pass]
    .chat.h: @[value; 
        (hopen; (`$(string .server.address),":",(string user),":",pass; 300)); 
        {-2 "Could not connect to the server due to error: ", x; 0Ni}
    ]
 }
.chat.SendMsg: {[user; msg]
    .chat.checkConnection[];
    neg[.chat.h] (`.chat.SendMsg; user; msg)
 }
.chat.GetUsers: {[]
    .chat.checkConnection[];
    .chat.h ".chat.GetUsers[]"
 }
.z.pc: {
    if[x ~ .chat.h; 
        .chat.h: 0Ni; 
        0N!"Connection lost to the server."
    ]
 }

/
q Client/chatClient.q

.chat.Joins[`samuel; "1234"]
.chat.Joins[`kelly; "1234"]
.chat.Joins[`lawing; "dllm"]

.chat.SendMsg[`all; "hi guys"]

system "ping 127.0.0.1 -n 60 > nul";