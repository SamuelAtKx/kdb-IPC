/q authentication.q

.perm.authPath: `:Resources/.userAuth
.perm.auth: ([]username:`symbol$(); password:())
.perm.load: {
    $[.perm.authPath ~ key .perm.authPath;
        .perm.auth: get .perm.authPath;
        [
            0N!".userAuth file notFound: creating new one.";
            .[.perm.authPath; (); :; .perm.auth];
            0N!".userAuth file created."
        ]
    ];
 }
.perm.save: { .perm.authPath set .perm.auth }
.perm.encrypt: -33!
.perm.Add: {[name;pass] `.perm.auth upsert (name; .perm.encrypt pass); .perm.save[] }
.perm.Remove: {[name] delete from `.perm.auth where username=name; .perm.save[] }

.z.pw: {[name;pass] exec 0 < count i from .perm.auth where username=name, (.perm.encrypt pass) in password }

.perm.load[]