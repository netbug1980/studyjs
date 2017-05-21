#!/bin/sh


# resolve links - $0 may be a softlink
PRG="$0"

while [ -h "$PRG" ] ; do
  ls=`ls -ld "$PRG"`
  link=`expr "$ls" : '.*-> \(.*\)$'`
  if expr "$link" : '/.*' > /dev/null; then
    PRG="$link"
  else
    PRG=`dirname "$PRG"`/"$link"
  fi
done

PRGDIR=`dirname "$PRG"`

PRGDIR=$(cd `dirname $0`; pwd)
echo "当前文件夹：$PRGDIR"

# 备份文件夹
BAK_FOLDER="$PRGDIR/wars_bak"
if [ ! -d "$BAK_FOLDER" ]; then
	echo "备份文件夹不存在，创建一个 $BAK_FOLDER"
	mkdir "$BAK_FOLDER"
fi


# $1: Service Name str in [central | editsphere]
# $2: Porject Name str [nsite-central-servers | es-servers]
function check_update() {
	# 源文件，安装包
	SRC_FILE="$1-3.0.0-SNAPSHOT-*-setup.zip"
	# 解压到的文件夹
	TMP_FOLDER="$BAK_FOLDER/temp-$1"
	# 解压出来的文件夹
	EXT_FOLDER="$TMP_FOLDER/$2"
	# 解压出来的可执行文件
	EXT_FILE="$TMP_FOLDER/$2/$2-3.0.0-SNAPSHOT.jar"
	# 最后的安装文件夹
	TGT_FOLDER="$PRGDIR/$2"
	# 最后执行的文件
	EXE_FILE="$TGT_FOLDER/$2-3.0.0-SNAPSHOT.jar"
	# 安装完的服务名称
	SVC_NAME="$1"

	if ls $SRC_FILE >/dev/null 2>&1;then
		echo "================================================================================"
		echo "-  发现服务“$SVC_NAME”的安装文件$SRC_FILE !!!"

		if [ ! -d "$TGT_FOLDER" ]; then
			# 第一次安装
			echo "-  检测到安装目录不存在 $TGT_FOLDER"
			echo "-  执行初次安装进程，开始解压..."
			unzip -o "$SRC_FILE" -d "$PRGDIR"
			# cp -fvr "$TGT_FOLDER/config/examples/*" "$TGT_FOLDER/config/"
			# if [ ! -f "/etc/init.d/$SVC_NAME" ]; then
			# 	echo "删除已经存在的软连接 /etc/init.d/$SVC_NAME"
			# 	rm -f "/etc/init.d/$SVC_NAME"
			# fi
			# sta=`ps -ef |grep $SVC_NAME |grep -v "grep"`
			# if [  "$sta" != "" ]; then
			# 	echo "服务“$SVC_NAME”已经启动，尝试关闭..."
			# 	service $SVC_NAME stop
			# fi
			ln -sbv "$EXE_FILE" "/etc/init.d/$SVC_NAME"
			chmod +x "$EXE_FILE"
			chown nsite:nsite "$TGT_FOLDER"
			chmod -R 777 "/tmp/ignite"
			
			echo "-  恭喜，初次安装完成 !!!"
			echo "-  位于 $TGT_FOLDER"
			echo "-  请先修改文件 $TGT_FOLDER/config/ignite.xml"
			echo "               $TGT_FOLDER/config/nsite.properties"
			echo "-  然后执行 service $SVC_NAME start|stop|restart|force-reload|status|run"
		else 
			# 不是第一次安装
			echo "-  检测到安装目录已经存在 $TGT_FOLDER"
			echo "-  执行更新进程，开始解压..."
			if [ -d "$TMP_FOLDER" ]; then
				echo "-  删除临时目录 $TMP_FOLDER"
				rm -fr "$TMP_FOLDER"
			fi
			echo "-  解压到临时目录 $TMP_FOLDER"
			unzip -o "$SRC_FILE" -d "$TMP_FOLDER"
			if [ ! -f "$EXT_FILE" ]; then
				echo "-  没有找到更新可用的执行文件 $EXT_FILE"
			fi
			if [ -f "$EXT_FILE" ]; then
				echo ""
				echo "-  更新可执行文件 $EXE_FILE"
				sta=`ps -ef |grep $SVC_NAME |grep -v "grep"`
				# if [  "$sta" != "" ]; then
				# 	echo "服务“$SVC_NAME”已经启动，尝试关闭..."
				# 	service $SVC_NAME stop
				# fi
				rm -fr "$EXE_FILE"
				cp -fvT "$EXT_FILE" "$EXE_FILE"
				chmod +x "$EXE_FILE"
				chown -R nsite:nsite "$TGT_FOLDER"
				# service $SVC_NAME start
			fi
			echo "-  恭喜，更新完成 !!!"
			echo "-  请执行 service $SVC_NAME start|stop|restart|force-reload|status|run"
		fi

		echo "-  移动文件到备份文件夹 $SRC_FILE $BAK_FOLDER/"
		mv $SRC_FILE "$BAK_FOLDER"
		echo "================================================================================"
	else
		echo "================================================================================"
		echo "-  本次没有找到服务“$SVC_NAME”的安装文件，不需要安装或更新"
		echo "================================================================================"
	fi
}




check_update	"central"		"nsite-central-servers";
check_update	"editsphere"	"es-servers";
check_update	"mediasphere"	"ms-servers";


# rm -fr nsite-central-servers/logs/*
# rm -fr es-servers/logs/*
# rm -fr /var/run/central/central.pid 
# rm -fr /var/run/editsphere/editsphere.pid