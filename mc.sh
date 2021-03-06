#!/bin/bash

cp $(pwd)/mc.sh /usr/bin
mv /usr/bin/mc.sh /usr/bin/mc-start

echo "========================="
echo -e "\033[32m 感谢使用我的世界启动脚本 \033[0m"
echo -e "\033[32m Author：筱晨~ \033[0m"
echo -e "\033[32m Home：www.svip13.cn\033[0m"
echo -e "\033[32m Version：1.1 \033[0m"
echo -e "\033[32m Github: https://github.com/Geek-Xiaochen/mc_start \033[0m"
echo "========================="
echo -e "\033[33m 请稍等... \033[0m"
echo -e "\033[32m 查找Bedrock_server目录中... \033[0m"
#搜索我的世界源文件路径 /root/mc/bedrock_server
	source=$(find /* -name "bedrock_server"  | grep -v "proc" )
#提取我的世界源文件位置 /root/mc/
	route=$(find /* -name "bedrock_server"  | grep -v "proc" | sed '$ s/bedrock_server//' )
echo -e "\033[32m 已找到文件位置 \033[0m"
#Test OK!
echo -e "\033[33m 终端输入 mc-start 调用此脚本\033[0m"
echo -e "\033[32m 1.\033[0m 开始运行Bedrock_Server"
echo -e "\033[32m 2.\033[0m 强制停止Bedrock_Server"
echo -e "\033[32m 3.\033[0m 开机自启Bedrock_server"
echo -e "\033[32m 4.\033[0m 更新脚本到最新"
echo -e "\033[32m 5.\033[0m 退出脚本"

read -n1 -p "请选择：" num
printf "\n"

case $num in
    "1")
    
	cd $route
	log=$(date "+%Y%m%d_logs")
	touch "$route"mclogs/$log

	screen_name=$"mc_xiaochen"
	screen -dmS $screen_name
	mcstart=$""$route"bedrock_server";
	screen -x -S $screen_name -p 0 -X stuff "$mcstart"
	screen -x -S $screen_name -p 0 -X stuff "\n"
	
	echo -e "\033[32m 开启成功! \033[0m"


#Nohup备用方案
#nohup ./bedrock_server >/root/mc/mclogs/$log 2>&1 &

    ;;
    "2")
		echo -e "\033[33m ===手动停止教程=== \033[0m"
		echo -e "\033[32m 第一步：在终端键入 screen -r mc_xiaochen \033[0m"
		echo -e "\033[32m (会进入一个新的窗口，请记住后面步骤)\033[0m"
		echo -e "\033[32m 第二步：手动键入 stop 停止运行 \033[0m"
		echo -e "\033[32m 第三步：使用快捷键 Ctrl + D 退出screen窗口 \033[0m"
		print "\n"
		echo -e "\033[31m 继续强制停止 Bedrock_Server ? \033[0m"
		
		read -n 1  -p "请输入Y\N or y\n " stopmc

		case $stopmc in
		"Y")
    			pid=$(screen -ls | grep mc_xiaochen | cut -d "." -f 1)
				kill $pid > /dev/null 2>&1
				printf "\n"
				echo -e "\033[32m 已成功停止Bedrock_Server \033[0m"
		;;
		"y")
    			pid=$(screen -ls | grep mc_xiaochen | cut -d "." -f 1)
				kill $pid
				echo -e "\033[32m 已成功停止Bedrock_Server \033[0m"
		;;
		"N")
			echo -e "\033[32m 已取消 \033[0m"
		;;
		"n")
			echo -e "\033[32m 已取消 \033[0m"
		;;
		*)
			echo -e "\033[32m 输入错误 \033[0m"
		;;
		esac
    ;;
    "3")
    		wget https://www.svip13.cn/sh/mcstart/mcstart.sh > /dev/null 2>&1
    		mv $(pwd)/mcstart.sh /usr/bin/mcstart.sh
		    chmod +x /usr/bin/mcstart.sh

		echo "
[Unit]
Description=筱晨我的世界开机自启动
After=sshd.service

[Service]
WorkingDirectory=/root
Type=forking
ExecStart=/usr/bin/mcstart.sh

[Install]
WantedBy=multi-user.target
" > /etc/systemd/system/xcmc.service

		sudo systemctl daemon-reload > /dev/null 2>&1
		sudo systemctl enable xcmc.service > /dev/null 2>&1
		echo -e "\033[32m 设置开机自启动成功 \033[0m"

    ;;
    "4")
    rm $(pwd)/mc.sh
    wget https://www.svip13.cn/sh/mcstart/mc.sh > /dev/null 2>&1 && chmod +x mc.sh
    echo -e "\033[31m 已更新至最新版本！ \033[0m"
    bash mc.sh
    ;;
    "5")
    
	echo -e "\033[32m 已退出此脚本 \033[0m"
		
    ;;
    *)
	echo -e "\033[32m 输入错误，请重新执行此脚本 \033[0m"
    ;;
esac
