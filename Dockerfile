# 使用 Alpine 作为基础镜像
FROM alpine:3.14

# 安装 Node.js 和 npm
RUN apk add --update nodejs npm

# 安装其他依赖
RUN apk add --no-cache curl bash zsh procps

# 设置工作目录
WORKDIR /app

# 复制 package.json 和 package-lock.json（如果存在）
COPY package*.json /app/

# 安装项目依赖
RUN cd /app && npm install

# 复制项目文件，包括已存在的 start.sh
COPY . /app/

# 确保 start.sh 是可执行的
RUN chmod +x /app/start.sh

# 设置默认端口
ENV PORT=3000

# 暴露应用端口（将使用环境变量）
EXPOSE ${PORT}

# 设置启动命令
CMD ["/bin/sh", "-c", "/app/start.sh"]
