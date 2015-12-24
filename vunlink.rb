
load File.dirname(__FILE__)+'/core/config.rb'
load File.dirname(__FILE__)+'/core/scanlib.rb'

options = ARGV[0]
#url = ARGV[1]
#type = ARGV[2]
#no = ARGV[3]
banner()
case options
when "-s"
	require 'webrick'
	if ARGV.length == 2
	server = WEBrick::HTTPServer.new({:BindAddress => '127.0.0.1',
		                          :Port => ARGV[1]})
	server.mount('/', WEBrick::HTTPServlet::FileHandler, Dir.pwd+'/web_view',
		            {:FancyIndexing => true})
	server.mount('/report', WEBrick::HTTPServlet::FileHandler, Dir.pwd+'/web_view/report',
		            {:FancyIndexing => true})
	trap(:INT){server.shutdown}
	server.start
	else
	puts "\n[ERROR] Invalid Argument\n\n"
	usage()
	end
when "-a"
	if ARGV.length == 4
	rows = $db.execute( "select scan_no from scan_list order by scan_no DESC limit 1" )
	new_no = rows[0][0]
	new_no += 1
	puts "[ADD] Scan Queue NO :: "+new_no.to_s
	scan_name = ARGV[1]
	scan_url = ARGV[2]
	scan_type = ARGV[3]
	#Push Scan
	scan_add(new_no,scan_name,scan_url,scan_type)
	#Run Scan
	scan_run(new_no)
	else
	puts "\n[ERROR][SCAN ADD] Invalid Argument\n\n"
	usage()
	end
when "-l"
	puts "| NO | SERVICE | URL | TYPE | STATE | REPORT PATH |"
	scan_list()
when "-d"
	if ARGV.length == 4
	#run
	else
	puts "\n[ERROR] Invalid Argument\n\n"
	usage()
	end
when "-c"
	#check run
	scan_run(1)
else
	usage()
end


