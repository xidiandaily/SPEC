#/bin/bash
[[ `uname` != 'Linux' ]] && echo "Must run on Linux \n" && exit;

if [ -z `uname -r |grep '2.6.32'` ];then
    echo "处理器型号：":`cat /proc/cpuinfo |grep "model.*name" | sed 's/.*://' | sort |uniq`;
    echo "物理CPU个数：":`cat /proc/cpuinfo |grep "physical id" | sed 's/.*://' | sort |uniq | wc -l`;
    echo "物理CPU包含的核数"`cat /proc/cpuinfo |grep "physical id" | sed 's/.*://' | sort |uniq | wc -l`;
    echo "每颗CPU处理器硬件线程：":`cat /proc/cpuinfo |grep "siblings" | sed 's/.*://' | sort  | uniq`;
    echo "系统逻辑CPU数：":`cat /proc/cpuinfo |grep "processor" | wc -l`;
    echo "L1 缓存 L2 缓存大小 L3缓存大小";cd /sys/devices/system/;find -type f |grep cpu0 |grep -w size | sort | xargs cat | xargs echo;cd -;
    echo "处理器最大时钟频率:"`cat /proc/cpuinfo|grep MHz |head -n 1`;
    echo "处理器指令宽度(每个指令周期完成的指令):现代处理器一般是3~4"
    echo "CPU开启的功能列表:";cat /proc/cpuinfo | grep "flags.*:" | head -n 1 | sed "s/flags.*://" | xargs -n 1 | sort | head -n 10 | xargs -n 1 -I {} grep -w {} cpuinfo_flages.data;
else
    [[ -z `rpm -qa |grep util-linux` ]] && echo "miss lscpu command;  Please run: yum -y install util-linux. ;-)" && exit;
    echo "处理器型号：":`cat /proc/cpuinfo |grep "model.*name" | sed 's/.*://' | sort |uniq`;
    echo "物理CPU个数：":`/usr/bin/lscpu |grep "Socket(s)"`;
    echo "每颗物理CPU包含的核数:"`/usr/bin/lscpu |grep "Core.*socket"`;
    echo "每个CPU核心包含硬件线程：":`/usr/bin/lscpu |grep "Thread.*core"`;
    echo "系统逻辑CPU数：":`cat /proc/cpuinfo |grep "processor" | wc -l`;
    echo "L1 缓存大小:"`lscpu  |grep L1`;
    echo "L2 缓存大小:"`lscpu  |grep L2`;
    echo "L3 缓存大小:"`lscpu  |grep L3`;
    echo "处理器最大时钟频率:"`lscpu  |grep MHz`;
    echo "处理器指令宽度(每个指令周期完成的指令):现代处理器一般是3~4"
    echo "CPU开启的功能列表(仅显示10项):";
    cat /proc/cpuinfo | grep "flags.*:" | head -n 1 | sed "s/flags.*://" | xargs -n 1 | sort | head -n 10 | xargs -n 1 -I {} grep -w {} cpuinfo_flages.data ;
fi

