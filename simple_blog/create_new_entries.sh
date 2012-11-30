curl localhost:9292 -d 'body=what+else?' -H "ACCEPT: application/json,*/*" &
curl localhost:9292 -d 'body=something+more?' -H "ACCEPT: application/json,*/*" &
curl localhost:9292 -d 'body=this+works' -H "ACCEPT: application/json,*/*" &
curl localhost:9292 -d 'body=and+one+more' -H "ACCEPT: application/json,*/*" &
