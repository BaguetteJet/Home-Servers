@echo off
start http://localhost:9000/
echo Keep this terminal window open
echo Access GUI via URL: http://localhost:9000/
ssh -L 9000:localhost:8384 <user>@<server-ip>
pause