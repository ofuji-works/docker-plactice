---
backgroundColor: white
marp: true
header: 'header text'
footer: ''footer text'
---


# docker勉強会 part1

### 本日の資料
```
$ git clone https://github.com/ofuji-works/docker-plactice.git
```


---

# はじめに
- 複数回に分けて実施したいと思います。
- 一方的に喋るのではなく、コミュニケーション取りながらやりたい！
- チームの開発手法の一つとして選択してもらえるようにしたい！

---

# 本日のゴール
- dockerの概要を掴みましょう
- docker imageを使ってコンテナが立ち上げる
- Dockerfileの中身を知る

---


# 目次
0. dockerデスクトップのインストール
1. docker概要
2. docker hub
3. docker imageからdocker containerを作成
4. docker imageを作成してdocker containerを作成
5. まとめ


---

# dockerデスクトップのインストール

---


# docker概要
- dockerとは
- dockerを使うメリット
- 活用事例


---


### dockerとは
> コンテナ仮想マシンツール

> コンテナという単位で実行環境を作れる

> VMよりも軽い


---


### メリット
> 自分のPC(ローカル環境)を汚さずに済む

> aws上で開発しなくても同じ環境で開発ができる

> git, svnで差分ツールを見ながら開発ができる

### デメリット


---


# docker hub
> dockerのgithubみたいなもの？


---


# docker imageからdocker containerを作成

```
# docker imageをdockerhubより取得します。
$ docker image pull gihyodocker/echo:latest
# プルしてきたイメージでコンテナーを起動
$ docker container run -t -p 9000:8080 gihyodocker/echo:latest

# 起動してるか確認
$ curl http://localhost:9000
Hello Docker!

# stop
$ docker container ls
$ docker stop コンテナid
```
- -t 疑似ターミナル (pseudo-TTY) を割り当て
- -p ポートフォワーディングの設定


---


# docker imageを作成してdocker containerを作成
docker imageはDockerfileに書かれた設定を元に作成できる。
Dockerfileを開いてください。


---


```
# 使用するベースとなる docker image の指定
FROM php:7.3-apache
# ホスト側のソースをコンテナ内にコピー
COPY ./php/php.ini /etc/php/
COPY ./apache/*.conf /etc/apache2/sites-available/
COPY ./laravel-app /var/www/html
# docker image build時に実行するコマンド
RUN apt-get update \
   && apt-get -y install \
   vim \
   zlib1g-dev \
   libpq-dev \
   libzip-dev \
   mariadb-client \
   unzip \
   cron \
   vim \
   wget \
   gnupg \
   && docker-php-ext-install zip
...
# 環境変数の設定
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /composer
ENV PATH $PATH:/composer/vendor/bin
# 実行するコンテナプロセスのワークディレクトリを指定
WORKDIR /var/www/html
...
```


---


```
# docker image build -t [イメージ名:タグ名] [Dockerfileのあるディレクトリパス]
# -t コンテナイメージ名:タグ名
$ docker image build -t docker-plactice:1.0 .

# docker run -d -p ホスト側:コンテナ側 --name コンテナ名指定(任意) 起動するコンテナイメージ
# -d デーモンで起動
# -p ポートフォワーディング
# --name コンテナ名
$ docker run -d -p 8000:8000 --name docker-plactice  docker-plactice:1.0
```
ブラウザを開いてlocalhost:8000にアクセス


---
# まとめ
- 案件ごとの専用環境をローカルで作成できる
- git, svnで差分をツールで確認しながら開発しやすい
- docker containerはdocker imageから作る
- docker image は Dockerfileから作る