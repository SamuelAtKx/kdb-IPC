.perm.encrypt: -33!
.perm.auth: ([]username:`symbol$(); password:())

.perm.authPath: `$":", .z.x 0 / `:Resources/.userAuth.txt
.perm.txt2auth: {[texts]
    columns: ":" vs/: texts;
    flip `username`password!(`$columns[;0] ; "X" $/: 2 cut/: columns[;1])
 }
.perm.auth2txt: {[]
    ":" sv/: flip exec (string username; raze each string password) from .perm.auth
 }

.perm.load: {
    $[.perm.authPath ~ key .perm.authPath;
        .perm.auth: .perm.txt2auth read0 .perm.authPath;
        [
            0N!".userAuth file notFound: creating new one.";
            h:hopen .perm.authPath; hclose h;
            0N!".userAuth file created."
        ]
    ];
 }
.perm.save: { .perm.authPath 0: .perm.auth2txt[] }

.perm.Add: {[name;pass] `.perm.auth upsert (name; .perm.encrypt pass); .perm.save[] }
.perm.Remove: {[name] delete from `.perm.auth where username=name; .perm.save[] }

.perm.pw: {[name;pass] exec 0 < count i from .perm.auth where username=name, (.perm.encrypt pass) in password }
.z.pw: {[name;pass] .perm.pw[name;pass] }

.perm.load[]

/
q Server/authentication.q Server/Resources/userAuth.txt -p 6000