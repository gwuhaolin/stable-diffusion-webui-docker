FROM archlinux:latest

# 更新系统并安装必要的包
RUN pacman -Syu --noconfirm base-devel git wget

# 工作目录

# 安装yay
RUN useradd -ms /bin/bash yay
USER yay
RUN git clone https://aur.archlinux.org/yay-bin.git
RUN cd yay-bin
RUN makepkg -si
RUN cd ../
RUN rm -rf yay-bin

# 安装python3.10
USER root
RUN yay -S --noconfirm python310

# 安装sdwebui
WORKDIR /sdw
RUN wget -q https://raw.githubusercontent.com/AUTOMATIC1111/stable-diffusion-webui/master/webui.sh
RUN sh ./webui.sh

