FROM archlinux:latest

# 更新系统并安装必要的包
RUN pacman -Syu --noconfirm base-devel git wget

# 设置AUR helper的下载目录
WORKDIR /sdw

# 克隆yay的AUR仓库
RUN git clone https://aur.archlinux.org/yay-bin.git
RUN cd yay-bin
RUN makepkg -si

RUN cd ../
RUN rm -rf yay-bin

RUN yay -S --noconfirm python310

RUN wget -q https://raw.githubusercontent.com/AUTOMATIC1111/stable-diffusion-webui/master/webui.sh

RUN chmod +x webui.sh

RUN sh ./webui.sh

