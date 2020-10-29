FROM ubuntu:18.04
###### BASIC LINUX ENVIRONMENT EIDITED BY YUHAO LONG(MOCKI) #####
MAINTAINER mocki <605095234@qq.com>
# change source
ENV USER mocki
ENV user_dir /home/${USER}
RUN mkdir -p ${user_dir}
RUN mkdir -p /etc/bash_completion.d
RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list
RUN apt-get clean
RUN apt-get update && apt-get install -y --no-install-recommends \ 
        build-essential \
		net-tools \
        curl \
        wget \
        cpio \
        openssh-server \
        openssh-client \
        gdb \
        libmysqlclient-dev \ 
        vim \
        git \
		python \
		llvm \ 
		clang \
		cmake

RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
RUN sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config
RUN echo sshd: ALL >> /etc/hosts.allow
# install mkl(all components) -> mkl path : /opt/intel/compilers_and_libraries_2020.1.217
ENV mklpath /usr/local/
ADD ./l_mkl_2020.1.217.tgz ${mklpath}
RUN sed -i 's/COMPONENTS=DEFAULTS/COMPONENTS=ALL/g' ${mklpath}/l_mkl_2020.1.217/silent.cfg
RUN ${mklpath}/l_mkl_2020.1.217/install.sh -s ${mklpath}/l_mkl_2020.1.217/silent.cfg --accept_eula
# change passwd
RUN echo "root:123456" | chpasswd
# set time zone
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo 'Asia/Shanghai' >/etc/timezone

EXPOSE 22
CMD ["/bin/bash"]
# open ssh port -> service ssh start