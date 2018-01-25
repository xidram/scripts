#!/bin/bash

socat tcp-l:2345,reuseaddr,fork exec:/bin/login,pty,setsid,setpgid,stderr,ctty
