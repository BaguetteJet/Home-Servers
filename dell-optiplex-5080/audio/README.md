# Audio

Optiplex 5080 has a built in speaker... why not use it?

# Setup

*COMPLETED 11/05/2026*

View sound cards available to check for speakers
```bash
cat /proc/asound/cards
```

Install audio utils
```bash
sudo apt update
sudo apt install alsa-utils
```

Check available outputs
```bash
sudo aplay -l
```

Volume mixer
```bash
sudo alsamixer
```

## Play MP3

Install .mp3 file player
```bash
sudo apt install mpg123
```
```sudo apt install mpg321``` alternative basic player (can't pause)

Play audio
```bash
sudo mpg123 song.mp3
```
```+/-``` volume   
```space``` pause    
```q``` quit   
```h``` help   

