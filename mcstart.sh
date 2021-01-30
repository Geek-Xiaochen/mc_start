#!/bin/bash
#搜索我的世界源文件路径 /root/mc/bedrock_server
	source=$(find /* -name "bedrock_server"  | grep -v "proc" )
#提取我的世界源文件位置 /root/mc/
	route=$(find /* -name "bedrock_server"  | grep -v "proc" | sed '$ s/bedrock_server//' )
#Test OK!
    
	cd $route
	log=$(date "+%Y%m%d_logs")
	touch "$route"mclogs/$log

	screen_name=$"mc_xiaochen"
	screen -dmS $screen_name
	mcstart=$"$route/bedrock_server";
	screen -x -S $screen_name -p 0 -X stuff "$mcstart"
	screen -x -S $screen_name -p 0 -X stuff "\n"
	
	echo -e "\033[32m 开启成功! \033[0m"
