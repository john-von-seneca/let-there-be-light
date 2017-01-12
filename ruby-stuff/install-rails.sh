sudo apt-get update
sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev

cd ~/neo-human/repos/rbenv/

ln -sr rbenv ~/.rbenv/
ln -sr ruby-build ~/.rbenv/plugins/ruby-build

rbenv install 2.3.1
rbenv global 2.3.1

source ~/.zshrc

ruby -v

gem install bundler

rbenv hash

curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -

in nodejs

gem install rails -v 4.2.6

rbenv rehash
