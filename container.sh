#!/bin/bash

# docker 容器打包
docker_build() {
    docker_kill
    docker-compose -f ./files/docker-compose.yml up --build -d
}

# docker 开始运行
docker_start() {
    if [ -n "`docker ps --format "{{.Names}}" --filter name=canren-lnmp`" ]; then
        docker start `docker ps -a --format "{{.Names}}" --filter name=canren-lnmp`
        echo -e "\033[32mall start"
    fi
}

# docker 停止运行
docker_stop() {
    if [ -n "`docker ps --format "{{.Names}}" --filter name=canren-lnmp`" ]; then
        docker stop `docker ps -a --format "{{.Names}}" --filter name=canren-lnmp`
        echo -e "\033[32mall stop"
    fi
}
# docker 重新启动
docker_restart() {
    if [ -n "`docker ps --format "{{.Names}}" --filter name=canren-lnmp`" ]; then
        docker restart `docker ps -a --format "{{.Names}}" --filter name=canren-lnmp`
        echo -e "\033[32mall restart"
    fi
}
# docker 容器删除
docker_kill() {
    docker_stop
    if [ -n "`docker ps -a --format "{{.Names}}" --filter name=canren-lnmp`" ]; then
        docker rm `docker ps -a --format "{{.Names}}" --filter name=canren-lnmp`
        echo -e "\033[31mall kill"
    fi
}
case "$1" in
start)
        docker_start
        ;;

stop)
        docker_stop
        ;;

restart)
        docker_restart
        ;;

build)
        docker_build
        ;;

kill)
        docker_stop
        docker_kill
        ;;
*)
        echo $"Usage: $prog {build|start|stop|restart|kill}"
        exit 1
esac
