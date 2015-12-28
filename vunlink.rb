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
	server.mount('/report/', WEBrick::HTTPServlet::FileHandler, Dir.pwd+'/web_view/report/',
		            {:FancyIndexing => true})
	server.mount_proc '/add' do |req,res|    #Add page
				res['Content-Type'] = "text/html"
				res['Content-Type'] = "text/html"
				res.body =wscan_list().to_s
				end
	server.mount_proc '/list' do |req,res|    #List page
				res['Content-Type'] = "text/html"
				res.body ='CODEBLACK'+wscan_list().to_s
				end
	server.mount_proc '/add_q' do |req,res|    #Add page
				res.body ='CODEBLACK'+wscan_list().to_s
				end
	trap(:INT){server.shutdown}
	server.start
	else
	puts "\n[ERROR] Invalid Argument\n\n"
	usage()
	end
when "-a"
	rows=nil
	if ARGV.length == 4
	rows = $db.execute("select scan_no from scan_list order by scan_no DESC limit 1")
	if rows.size == 0
		new_no = 1
	else
		new_no = rows[0][0]
		new_no += 1
	end
	puts "[ADD] Scan Queue NO :: "+new_no.to_s
	scan_name = ARGV[1]
	scan_url = ARGV[2]
	scan_type = ARGV[3]
	#Push Scan
	scan_add(new_no,scan_name,scan_url,scan_type)
	#Check Run Scan
	running = scan_check("run")
	if running == 0
		#Run Scan
		scan_run(new_no)
	end
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
	rows = $db.execute("select scan_no from scan_list order by scan_no DESC limit 1")
	print rows.size
	if rows.size == 0
		puts "Null"
	else
		puts "Not Null"
	end
else
	usage()
end


