load File.dirname(__FILE__)+'/config.rb'
load File.dirname(__FILE__)+'/scanlib.rb'

## scan.rb check 1 /test/setset
## scan.rb loop 1 /test/setset

mode = ARGV[0]
scan_no = ARGV[1]
scan_report_path = ARGV[2]

case mode
when "check" 

when "loop"

else
end


rows = $db.execute("select scan_name, scan_url from scan_list where scan_no ='#{scan_no}'")


#pid = IO.popen("sleep 10;ruby #{$myscriptroot}/endScan.rb #{no} report/#{myJob_path}","w+")

rows = $db.execute( "select * from scan_list" )

scan_rdy = scan_check("rdy")
scan_run = scan_check("run")

if scan_rdy == -1
# Add scan
# Run scan -> #run this file
else
# Run scan -> #run this file
end


