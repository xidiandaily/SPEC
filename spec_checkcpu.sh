#/bin/bash
[[ `uname` != 'Linux' ]] && echo "Must run on Linux \n" && exit;

[[ -z `rpm -qa |grep -e "sysstat" |grep -v grep` ]] && echo "miss sysstat command; Please run: yum -y install sysstat;-)" && exit;

echo "CPU 利用率(%idle约大，空闲率越高):mpstat -P ALL";mpstat -P ALL | grep -e "CPU" -e "all" -e "^[0-9]";
echo "CPU 饱和度:";sar -q | cat |grep runq; sar -q |tail -n 10;
echo "CPU 错误:"

[[ -z `uname -r |grep '2.6.32'` ]] && echo "Must run on kernel version >= 2.6.31;" && exit;
[[ -z `rpm -qa |grep -e "perf" |grep -v grep` ]] && echo "miss perf command; Please run: yum -y install perf ;-)" && exit;
[[ `cat /proc/sys/kernel/kptr_restrict ` = "0"  ]] && echo "cat /proc/sys/kernel/kptr_restrict 0. It' Must be 1. Please run: 'sudo su; echo 1 > cat /proc/sys/kernel/kptr_restrict;'"  && exit;
echo "CPU 的 CPI( cycles-per-instruction) 越低越好：sudo perf stat -B -a sleep 10";sudo perf stat -B -a sleep 10;
echo "CPU 的 停滞周期及停滞周期类型："
echo "CPU 的 指令："
echo "CPU 的 L1 命中率："
echo "CPU 的 L2 命中率："
echo "CPU 的 L3 命中率："
echo "CPU 的 内存I/O 读、写、停滞周期："
echo "CPU 的 资源I/O 读、写、停滞周期："

