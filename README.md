## 容器结构

本项目使用 Docker Compose 部署多个容器:

- `mongodb` - MongoDB 数据库容器
- `mariadb` - MariaDB 数据库容器
- `phpmyadmin` - phpMyAdmin 容器
- `redis` - Redis 数据库容器
- `mc` - Minecraft 服务端容器

## 项目结构

这里说明了每个文件/文件夹的大致用途:

- `mariadb` - MariaDB 数据库相关文件
  - `conf/` - 配置文件, 将挂载到容器
  - `data/` - 数据文件, 将挂载到容器
- `minecraft` - Minecraft 相关文件
  - `app/` - 服务端文件, 将挂载到容器
    - `game1/` - 游戏服务端 1
    - `game2/` - 游戏服务端 2
    - `game3/` - 游戏服务端 3
    - `game4/` - 游戏服务端 4
    - `proxy/` - 用于组建游戏服务端的网络
    - `router/` - 用于转发玩家到合适的网络
    - `update-paper-jar.sh` - 更新 Paper 服务端的脚本
    - `update-velocity-jar.sh` - 更新 Velocity 服务端的脚本
  - `jdk/` - JDK 文件, 与容器无关系
- `mongodb` - MongoDB 相关文件
  - `conf/` - 配置文件, 将挂载到容器
  - `data/` - 数据文件, 将挂载到容器
- `phpmyadmin` - phpMyAdmin 相关文件
  - `conf/` - 配置文件, 将挂载到容器
- `redis` - Redis 相关文件
  - `conf/` - 配置文件, 将挂载到容器
  - `data/` - 数据文件, 将挂载到容器

## 启动所有容器

前置要求: 请确保已安装 [Docker Desktop](https://www.docker.com/products/docker-desktop).

1. 使用 Visual Studio Code 打开本项目.
2. 打开 `compose.yml` 文件.
3. 点击 `services` 节点上方生成的 `[➔ Run All Services]` 按钮.

## 进入 `mc` 容器

根据您的操作系统, 运行以下脚本之一即可进入 `mc` 容器:

- 对于 Linux 或 macOS 用户, 运行 `aethermc.sh`:
  ```sh
  ./aethermc.sh
  ```

- 对于 Windows 用户, 运行 `aethermc.bat`:
  ```bat
  aethermc.bat
  ```

## Minecraft 容器内操作

进入 `mc` 容器后, 默认位于 `/minecraft` 目录下.

这个目录下的每个子文件夹都是一个服务端.

每个服务端目录下都有一个 `go.sh` 脚本, 用于启动当前服务端.

运行以下命令启动服务端:

```sh
./go.sh
```

然后就会启动一个 `tmux` 会话, 相当于一个新的窗口, 负责运行当前的服务端.

要在 `tmux` 会话中滚动日志, 您可以使用 `Ctrl + B, [` 来进入滚动模式, 然后再使用:
- `鼠标滚轮`
- `方向键上` 和 `方向键下`
- `Page Up` 和 `Page Down`

您可以使用 `Ctrl + B, D` 来退出 `tmux` 会话, 这相当于最小化窗口, 不会终止服务端运行.

这样您就可以同时运行多个服务端, 并且可以随时切换到其他服务端的 `tmux` 会话.

要重新进入一个服务端的 `tmux` 会话, 在对应的目录里再次执行 `./go.sh` 即可.
