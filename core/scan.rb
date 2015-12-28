load File.dirname(__FILE__)+'/config.rb'
load File.dirname(__FILE__)+'/scanlib.rb'

## scan.rb check 1 /test/setset
## scan.rb loop 1 /test/setset

mode = ARGV[0]
scan_no = ARGV[1]
scan_report_path = ARGV[2]

case mode
when "check" 
#이부분은 ???

when "loop"
#이부분에선 들어온 scan_no를 fin 처리하고 추가 돌릴 스캔이 있는지 확인 후 돌림
	scan_fin(scan_no,scan_report_path) #Finish Proc
	running = scan_check("run") #Rdy Scan Check
	if running == 0
		rows = $db.execute("select scan_no from scan_list where scan_state='rdy' order by scan_no DESC limit 1")
		no = rows[0][0]
		#Run Scan
		scan_run(no)
	else
		puts "End Scan Queue"
	end
else
	puts "Not Method"
end
