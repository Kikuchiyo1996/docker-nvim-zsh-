FROM ubuntu:latest

# Install basic tools
RUN apt-get update -y && apt-get -y install ssh \
      vim \
      wget \
      curl \
      sudo  \
      git \
      openssh-server 

# Install zsh
RUN  apt-get install -y zsh \ 
      && git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh \ 
      # && cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc \
      && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting \
      && git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Install neovim
RUN apt-get -y install -y software-properties-common  \
      build-essential \
      && add-apt-repository ppa:neovim-ppa/unstable && apt-get install -y neovim

# copy profile
COPY .zshrc /root/.zshrc
COPY .config/ /root/.config

# change shell to zsh 
RUN  chsh -s /bin/zsh 

# Clean apt-cache
RUN apt autoremove -y && apt clean -y 
# 定义容器启动时执行的命令
# CMD ["zsh"]