FROM rockylinux:8

# 安装编译工具
RUN dnf install -y gcc gcc-c++ make python3 git cmake

# 安装 EPEL 和 fmt-devel
RUN dnf install -y https://mirrors.tuna.tsinghua.edu.cn/epel/epel-release-latest-8.noarch.rpm && \
    dnf install -y fmt-devel

# 安装 Node.js 18
RUN dnf module enable -y nodejs:18 && \
    dnf install -y nodejs npm && \
    npm install -g yarn

WORKDIR /workspace

CMD ["bash"]
