# VunLink
###Auto Web Vulnerability Scanning Framework<br>
VunLink is Auto Web Vulnerability Scanning Framework<br><br>
> Code by HaHwul [www.codeblack.net]<br>
> http://www.codeblack.net/p/vunlink.html

> Include Program / Project<br>
> 1. google skipfish<br>
> [ apt-get install skipfish ] <br>
> 2. ruby WEBrick<br>

##Usage
Usage: # [options]<br>
  -s # Run Web Server<br>
     + -s [port]<br>
     + -s 10046<br>
  -a # Add Target<br>
     + -a [name][url][type]<br>
     + -a test http://127.0.0.1 remote<br>
  -l # View Scan List<br>
  -d # Delete Scan List<br>
  -c # Check Run<br>

##Install
1. Download VunLink
> git clone https://github.com/hahwul/VunLink.git

2. Install 3rd Packages
> apt-get install sqlite3<br>
> apt-get install ruby-sqlite3<br>
> gem install webrick<br>
> gem install sqlite3<br>


