# brockman

# apt-get update
if ! $updated_recently; then
  sudo apt-get update
  export updated_recently=TRUE
fi

# rvm
which_rvm=`which rvm`
if [ ! -z "$which_rvm" ]; then
  echo 'rvm already installed'
else
  gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
  curl -sSL https://get.rvm.io | sudo bash -s stable
  sudo usermod -a -G rvm `whoami`

  # set secure path options
  if sudo grep -q secure_path /etc/sudoers; then sudo sh -c "echo export rvmsudo_secure_path=1 >> /etc/profile.d/rvm_secure_path.sh" && echo Environment variable installed; fi

fi

ruby_version="$(ruby -e 'print RUBY_VERSION')"
right_version="2.2.3"
if [ $ruby_version == $right_version ]; then
  echo "ruby at correct version"
else
  # install ruby
  rvm install ruby-2.2.3
  rvm --default use ruby-2.2.3
fi


# bundler
which_bundler=`which bundler`
if [ ! -z "$which_bundler" ]; then
  echo "bundler already installed"
else
  sudo apt-get install bundler -y
  gem install bundler
fi

sudo bundle install --path vendor/bundle
