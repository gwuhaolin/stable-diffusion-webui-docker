# 使用最新的 archlinux 基础镜像
FROM archlinux:latest

# 更新系统并安装需要的依赖
RUN pacman -Syu --noconfirm \
    && pacman -S --needed --noconfirm base-devel git sudo

# 创建一个新用户来构建和使用 yay（不能使用 root 用户）
RUN useradd -m app \
    && passwd -d app \
    && printf 'app ALL=(ALL) ALL\n' | tee -a /etc/sudoers

# 切换到新用户
USER app

# 在用户家目录中工作
WORKDIR /home/app

# 克隆 yay-bin 仓库并构建它
RUN git clone https://aur.archlinux.org/yay-bin.git \
    && cd yay-bin \
    && makepkg -si --noconfirm


RUN curl -O https://raw.githubusercontent.com/AUTOMATIC1111/stable-diffusion-webui/master/webui.sh
RUN sh ./webui.sh

