## 容器结构

本项目使用 Docker Compose 部署多个容器 (containers):

- `mongodb` - MongoDB 数据库容器
- `mariadb` - MariaDB 数据库容器
- `phpmyadmin` - phpMyAdmin 容器
- `redis` - Redis 数据库容器
- `minecraft` - Minecraft 服务端容器

并且会创建以下卷 (volumes) 用于持久化数据:

- `aether_mongodb`
- `aether_mariadb`
- `aether_redis`
- `aether_minecraft`

## 项目结构

这里说明了每个文件/文件夹的大致用途:

- `java` - Java 基础镜像
  - `build-image.sh` - 构建 Java 基础镜像的脚本
- `mariadb` - MariaDB 数据库
  - `conf/` - 配置文件, 将复制到容器
  - `init.sql` - 初始化数据库的 SQL 语句
- `minecraft` - Minecraft 服务端
  - `src/` - 用于自行快速创建服务端的文件和脚本
- `mongodb` - MongoDB 数据库
  - `conf/` - 配置文件, 将复制到容器
- `phpmyadmin` - phpMyAdmin 数据库管理面板
  - `conf/` - 配置文件, 将复制到容器
- `redis` - Redis 数据库
  - `conf/` - 配置文件, 将复制到容器

## 启动所有容器

前置要求: 请确保您的电脑上已安装 [Docker Desktop](https://www.docker.com/products/docker-desktop).

1. 使用 Visual Studio Code 打开本项目.
2. 打开 `compose.yml` 文件.
3. 点击 `services` 节点上方由 VSCode 生成的 `[➔ Run All Services]` 按钮.

## 进入 Minecraft 容器

前置要求: 请确保您的 VSCode 已安装插件 [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers).

下面运行的脚本实际上是使用 *Dev Containers* 进入 Minecraft 容器.
如果进入成功, 您就可以通过 VSCode 直接操作容器内的文件和使用命令行.
体验类似 VSCode 的远程开发, 但是是在容器内进行的.

根据您的操作系统, 运行以下脚本之一即可进入 Minecraft 容器:

- 对于 Linux 或 macOS 用户, 运行 `attach-minecraft.sh`:
  ```sh
  ./attach-minecraft.sh
  ```

- 对于 Windows 用户, 运行 `attach-minecraft.bat`:
  ```bat
  attach-minecraft.bat
  ```

## Minecraft 容器内操作

**注意:** 以下内容并不是完整的操作指南, 仅作为备忘录使用!


进入 Minecraft 容器后, 工作目录默认位于 `/minecraft` 之下.

传统上这个目录用于存放各种服务端的文件, 一个典型的目录结构如下:
(该结构可以用于构建一个能够承载数百人的 Minecraft 生存服务器)

- `minecraft/`
  - `game1/` - Paper 服务端 1
  - `game2/` - Paper 服务端 2
  - `game3/` - Paper 服务端 3
  - `gameN/` - Paper 服务端 N
  - `proxy/` - Velocity 服务端, 用于组建 Paper 服务端的群组网络
  - `router/` - Velocity 服务端, 用于转发玩家到合适的服务器 IP 上

为了方便起见, 本项目提供了一些现成的服务端启动脚本:
  - 要创建一个 Paper 服务端, 使用 `./minecraft/src/paper` 下的文件.
  - 要创建一个 Velocity 服务端, 使用 `./minecraft/src/velocity` 下的文件.

同时也提供了以下脚本用于快速下载/更新 Paper 和 Velocity 服务端的 JAR 文件:
(您需要将这些脚本文件拷贝到与服务端文件夹同级的位置, 然后再执行脚本)
  - `./minecraft/src/shared-functions.sh`
  - `./minecraft/src/update-paper-jar.sh`
  - `./minecraft/src/update-velocity-jar.sh`

考虑到这些东西都比较基础, 这里不再介绍详细用法, 平日的语音里会做详细说明.

## 使用 tmux 操作服务端控制台

如果您使用的是本项目提供的 `go.sh` 脚本启动服务端, 执行后会启动一个 `tmux` 会话, 相当于一个新的窗口, 负责运行当前的服务端. `tmux` 的作用是允许您将程序放在“后台”运行, 并且可以随时进入查看和操作.

要在 `tmux` 会话中滚动控制台的日志, 您可以使用 `Ctrl + B, [` 来进入滚动模式, 然后再使用:
- `鼠标滚轮`
- `方向键上` 和 `方向键下`
- `Page Up` 和 `Page Down`

使用 `Ctrl + B, D` 来退出 `tmux` 会话, 这相当于最小化窗口, 不会终止服务端运行.

这样您就可以在容器内同时运行多个服务端, 并且可以随时切换到其他服务端的 `tmux` 会话.

要重新进入一个服务端的 `tmux` 会话, 在对应的目录里再次执行 `./go.sh` 即可.

更多关于 `tmux` 的使用方法请参考: [Tmux Cheat Sheet](https://tmuxcheatsheet.com/)
