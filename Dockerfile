FROM amazonlinux:latest

RUN yum update -y
RUN yum install -y passwd wget hostname tar make gcc zlib-devel git sudo net-tools ntp vim-enhanced gcc-c++ patch \
  bzip2 bzip2-devel openssl openssl-lib openssl-devel libxml2 libxml2-devel libxslt libxslt-devel libffi-devel.x86_64 readline-devel \
  ImageMagick ImageMagick-devel mysql56-common mysql56-devel mysql56-libs

# rbenvのインストール
RUN git clone https://github.com/sstephenson/rbenv.git /usr/local/rbenv
RUN echo '# rbenv setup' > /etc/profile.d/rbenv.sh
RUN echo 'export RBENV_ROOT=/usr/local/rbenv' >> /etc/profile.d/rbenv.sh
RUN echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /etc/profile.d/rbenv.sh
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
RUN chmod +x /etc/profile.d/rbenv.sh

# install ruby-build
RUN mkdir /usr/local/rbenv/plugins
RUN git clone https://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-build
ENV RBENV_ROOT /usr/local/rbenv
ENV PATH "$RBENV_ROOT/bin:$RBENV_ROOT/shims:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

# install ruby
RUN rbenv install 2.1.8 && rbenv global 2.1.8 && rbenv rehash && gem install bundler

# install nodejs
RUN curl -sL https://rpm.nodesource.com/setup_6.x | bash - && yum install -y nodejs

# install phantomJS
RUN npm -g install phantomjs-prebuilt
