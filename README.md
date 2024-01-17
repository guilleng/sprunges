Sprunges
--------

A bash script to interact with the pastebin service ()[https://sprunge.us/].


### Usage

```bash
$ sprunges -h
	Usage: sprunges [options] <value>

    fetch/post pastebins to https://sprunge.us. Track IDs in a /tmp file. 

    If no FILE specified, reads from stdin.

    -d [DESCRIPTION]     add a DESCRIPTION to the entry
    -f [FILE]            oupload FILE 
    -h                   show this help
    -l                   list pastebins table
    -n                   don't record URL to /tmp file
    -o                   output URL of uploaded pastebin to stdout
    -r [INDEX | ID]      retrieve pastebin by INDEX or ID 
```


### Installation

Requires `curl`.

Set execute permissions.  Make a symlink to the script.  If needed, create the
folder `~/.local/bin` and add it to your `$PATH`.

```bash
git clone
chmod +x sprunges/script.sh
ln -s "$(pwd)/sprunges/script.sh" ~/.local/bin/sprunges
```


### Examples:


```bash
$ sprunges -f lorem.txt
$ cat script.sh | sprunges -d 'bash script'
$ sprunges -d 'service settings' < /etc/systemd/system/my-service.service
$ sprunges -l
[0]	 http://sprunge.us/CiuK90	 
[1]	 http://sprunge.us/4rQI7a	 bash script	
[2]	 http://sprunge.us/Ul4PxY	 service settings	

$ sprunges -r 0

Lorem
=====

However, a neural pine without humidities is truly a saw of blackish prints.  A
bat is an ethernet's deficit.  The eel of an onion becomes an unmarked handicap.

$ echo 'test' | sprunges -no
http://sprunge.us/tOTy7r	 	
$ sprunges -r tOty7r
test
```
