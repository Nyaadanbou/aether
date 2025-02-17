#!/bin/bash

start_paper_server() {

    # 服务端的名字, 例如 game1, game2
    SERVER=$1
    # JVM 参数
    JVM_PARAMS=$2
    # APP 参数
    APP_PARAMS=$3

    tmux has-session -t $SERVER 2>/dev/null

    if [ $? != 0 ]; then
        tmux new-session -s $SERVER -n "main" "java $JVM_PARAMS -jar ignite*.jar $APP_PARAMS"
    else
        tmux attach-session -t $SERVER
    fi
}

download_server_jar() {

    # 项目名称
    PROJECT=$1
    # 项目版本
    MINECRAFT_VERSION=$2
    # 临时文件夹路径
    TEMP_DIR=$3

    LATEST_BUILD=$(curl -s https://api.papermc.io/v2/projects/${PROJECT}/versions/${MINECRAFT_VERSION}/builds |
        jq -r '.builds | map(select(.channel == "default") | .build) | .[-1]')

    if [ "$LATEST_BUILD" != "null" ]; then
        JAR_NAME=${PROJECT}-${MINECRAFT_VERSION}-${LATEST_BUILD}.jar
        PAPERMC_URL="https://api.papermc.io/v2/projects/${PROJECT}/versions/${MINECRAFT_VERSION}/builds/${LATEST_BUILD}/downloads/${JAR_NAME}"

        # 创建临时文件夹
        mkdir -p "$TEMP_DIR"

        # 下载文件
        curl -o "$TEMP_DIR/$PROJECT.jar" $PAPERMC_URL

        echo "Download completed"
    else
        echo "No stable build for version $MINECRAFT_VERSION found :("
    fi

}

copy_server_jar() {

    # 项目名称
    PROJECT=$1
    # 文件夹路径, 不以 “/” 结尾
    TARGET_DIR=$2
    # 临时文件夹路径
    TEMP_DIR=$3

    # 重命名旧文件
    for file in $(find "$TARGET_DIR" -name "${PROJECT}*.jar"); do
        i=1
        while [ -f "$file.$i" ]; do
            i=$((i + 1))
        done
        mv "$file" "$file.$i"
    done

    # 复制新文件
    cp "$TEMP_DIR/$PROJECT.jar" "$TARGET_DIR/$PROJECT.jar"

    echo "Copied $PROJECT.jar to $TARGET_DIR"
}
