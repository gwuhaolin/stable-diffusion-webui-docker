FROM archlinux:latest

# 更新系统并安装必要的包
RUN pacman -Syu --noconfirm base-devel git wget

# 创建一个新用户，避免以root用户运行yay
RUN useradd -ms /bin/bash myuser

# 切换到新创建的用户
USER myuser

# 设置AUR helper的下载目录
WORKDIR /home/myuser

# 克隆yay的AUR仓库
RUN git clone https://aur.archlinux.org/yay.git

# 进入yay目录
WORKDIR /home/myuser/yay

# 构建yay包
RUN makepkg -si --noconfirm

# 清理构建过程产生的临时文件
RUN rm -rf /home/myuser/yay

# 确保yay已经安装并且可以被新用户使用
RUN yay --version

RUN yay -S --noconfirm python310

RUN wget -q https://raw.githubusercontent.com/AUTOMATIC1111/stable-diffusion-webui/master/webui.sh

RUN chmod +x webui.sh

RUN sh ./webui.sh

