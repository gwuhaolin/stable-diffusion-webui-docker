FROM ubuntu:22.04

RUN apt-get update && apt-get install -y git wget python3-pip python3 python3-venv

# 创建一个新用户来构建和使用
RUN useradd -m app \
    && passwd -d app \
    && printf 'app ALL=(ALL) ALL\n' | tee -a /etc/sudoers

# 切换到新用户
USER app

# 在用户家目录中工作
WORKDIR /home/app
RUN wget -q https://raw.githubusercontent.com/AUTOMATIC1111/stable-diffusion-webui/master/webui.sh
RUN sh ./webui.sh

