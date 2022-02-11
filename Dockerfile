FROM ubuntu:18.04

ENV DEST /var/www/html

# 패키지 목록 갱신
RUN apt update

# 아파치 설치
RUN apt install apache2 -y
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE  /var/run/apache2/apache2.pid 

# 최신 버전의 패키지 설치를 위한 패키지 설치
RUN apt install software-properties-common -y

# php 저장소 추가
RUN add-apt-repository ppa:ondrej/php
# 다시 패키지 목록 갱신
RUN apt update

# php 설치 시 타임존 자동으로 입력하기 (-y 옵션 사용과 같은 이유)
ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# php 설치
RUN apt install php7.3 php7.3-common php7.3-cli -y
# php 자주 사용하는 모듈 설치
RUN apt install php7.3-bcmath php7.3-bz2 php7.3-curl php7.3-gd php7.3-intl php7.3-json php7.3-mbstring php7.3-readline php7.3-xml php7.3-zip php7.3-mysql -y
# php와 apache2 연결
RUN apt install libapache2-mod-php7.3

# php.ini 덮어쓰기
COPY ./php.ini /etc/php/7.3/apache2/php.ini

# 가상 호스트 설정 이미지에 카피
COPY ./visual.conf /etc/apache2/sites-available/visual.conf

# 카피한 가상 호스트 설정 파일 심볼 링크 설정
RUN ln -s /etc/apache2/sites-available/visual.conf /etc/apache2/sites-enabled/

EXPOSE 80

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
