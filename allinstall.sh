mkdir ~/.gems

echo 'export GEM_HOME="$HOME/.gems"' >> .bash_profile
echo 'export GEM_PATH="$GEM_HOME:/usr/lib/ruby/gems/1.8"' >> .bash_profile
echo 'export PATH="$HOME/.gems/bin:$PATH"' >> .bash_profile
echo 'export PATH="$HOME/local/bin:$PATH"' >> .bash_profile

. ~/.bash_profile
echo $PATH

touch ~/.gemrc
echo gemhome:/home/$(whoami)/.gems >> ~/.gemrc
echo gempath: >> ~/.gemrc
echo "- /home/$(whoami)/.gems" >> ~/.gemrc
echo "- /usr/lib/ruby/gems/1.8" >> ~/.gemrc

# setup directories
mkdir -p ~/packages
cd ~/packages

# Install readline
wget ftp://ftp.gnu.org/gnu/readline/readline-5.2.tar.gz
tar zxvf readline-5.2.tar.gz
cd readline-5.2
./configure --prefix=$HOME/local
make
make install
cd ..

# install ruby
wget ftp://ftp.ruby-lang.org/pub/ruby/1.8/ruby-1.8.7-p160.tar.gz
tar zxvf ruby-1.8.7-p160.tar.gz
cd ruby-1.8.7-p160.tar.gz
./configure --prefix=$HOME/local --with-readline-dir=$HOME/local/
make
make install
cd ..

# fix path
export PATH=$HOME/local/bin:$PATH

# get rubygems
wget http://rubyforge.org/frs/download.php/45905/rubygems-1.3.1.tgz
tar zxvf rubygems-1.3.1.tgz
cd rubygems-1.3.1
$HOME/local/bin/ruby setup.rb
cd ..

# Install RAILS
gem install rails

#if you use mod_rails, you need not fcgi any more
# Install FastCGI 
#curl -O http://www.fastcgi.com/dist/fcgi-2.4.0.tar.gz
# tar xzvf fcgi-2.4.0.tar.gz
# cd fcgi-2.4.0
# ./configure --prefix=$HOME/local
# make
# make install
# cd ..

# Install FastCGI & MySQL gem packages
# gem install fcgi -- --with-fcgi-dir=$HOME/local
gem install mysql -- --with-mysql-config

#Install oniguruma for ultraviolet
cd ~/packages
wget http://www.geocities.jp/kosako3/oniguruma/archive/onig-5.9.1.tar.gz
tar xvzf onig-5.9.1.tar.gz 
cd onig-5.9.1
./configure  --prefix=/home/leeseon/local/
make
make install

export C_INCLUDE_PATH=$HOME/local/include/
export LIBRARY_PATH=$HOME/local/lib/

#Install ultraviolet from tm_highlighting plugin
gem install ultraviolet
