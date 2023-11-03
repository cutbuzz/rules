	mkdir auto_spy_data
    docker run -dit --restart=always --name=auto_spy --hostname=auto_spy xieshang1111/auto_spy:$arch
	docker cp auto_spy:/autospy/ "$(pwd)"/auto_spy_data/autospy
	docker stop auto_spy
	docker rm auto_spy	
	echo -n -e "检测到autospy配置文件不存在，如之前直装过auto_spy,请输入绝对路径以完成配置文件一键迁移(如没安装过，直接回车即可)："
	read dir
	if [[ $dir != "" ]];then
	docker run -dit --restart=always --name=auto_spy --log-opt max-size=100m --log-opt max-file=3 -v "$(pwd)"/auto_spy_data/autospy:/autospy --hostname=auto_spy xieshang1111/auto_spy:$arch
	cp $dir/auto_spy.yaml "$(pwd)"/auto_spy_data/autospy
	docker exec -it auto_spy bash /autospy/start.sh
	exit 0
else
	mkdir auto_spy_data
	docker cp auto_spy:/autospy/ "$(pwd)"/auto_spy_data/autospy
	docker stop auto_spy
	docker rm auto_spy
	docker run -dit --restart=always --name=auto_spy --log-opt max-size=100m --log-opt max-file=3 -v "$(pwd)"/auto_spy_data/autospy:/autospy --hostname=auto_spy xieshang1111/auto_spy:$arch
	cp "$(pwd)"/auto_spy_data/autospy/auto_spy_simple.yaml "$(pwd)"/auto_spy_data/autospy/auto_spy.yaml
	echo -e "现在可以去目录下[auto_spy_data/auto_spy]里的[auto_spy.yaml]修改信息了\n修改完成后，请再次运行脚本\n"
	exit 0