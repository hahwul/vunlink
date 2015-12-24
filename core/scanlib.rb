load File.dirname(__FILE__)+'/config.rb'

$skipfishQ = "skipfish -W /dev/null -o #{$report_path}/skipfish"

##### Function ####
def scan_check(s_type)  #Scan Check Module
	rows = $db.execute( "select count(scan_state) from scan_list where scan_state='#{s_type}'" )
	puts rows
	return rows
end
def scan_run(scan_no)    #Run Scan Module
	rows = $db.execute("select scan_name, scan_url from scan_list where scan_no ='#{scan_no}'")
	scan_name = rows[0][0]
	scan_url = rows[0][1]
	time = Time.now.to_f
	myJob_path = "/"+time.to_s+"_"+scan_name
	scan_report_path=$report_path+myJob_path
	system ("mkdir #{scan_report_path} -m 777")
	#pid = IO.popen($skipfishQ+" #{scan_url}"+"; #{$core_path}scan.rb","w+")
end
def scan_add(scan_no,scan_name,scan_url,scan_type)    #New Scan Module
	rows = $db.execute("insert into scan_list values ('#{scan_no}','#{scan_name}','#{scan_url}','#{scan_type}','rdy','')")
end
def scan_fin(scan_no,scan_report)    #Finish Scan Module
	rows = $db.execute("")
end
def scan_list   #Scan List Module
	$db.execute( "select * from scan_list order by scan_state DESC limit 40" ) do |row|
	print row
	puts ""
end
end
def usage
	puts "Usage: # [options]"
	puts "  -s # Run Web Server"
	puts "     + -s [port]"
	puts "     + -s 10046"
	puts "  -a # Add Target"
	puts "     + -a [name][url][type]"
	puts "     + -a test http://127.0.0.1 remote"
	puts "  -l # View Scan List"
	puts "  -d # Delete Scan List"
	puts "  -c # Check Run"
end
def banner
	puts "### RUN ###"
	puts "### Code by HaHwul [www.codeblack.net] ###"
	puts "### Support [skipfish] ###"
end
