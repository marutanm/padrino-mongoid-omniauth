class Omniauth < Padrino::Application
  register Padrino::Mailer
  register Padrino::Helpers
  register Padrino::Admin::AccessControl

  enable :sessions

  use OmniAuth::Builder do
        provider :twitter,  ENV['twitter_key'], ENV['twitter_secret']
  end

  set :login_page, "/" # determines the url login occurs

  access_control.roles_for :any do |role|
      role.protect "/profile"
      role.protect "/admin" # here a demo path
  end

  # now we add a role for users
  access_control.roles_for :users do |role|
      role.allow "/profile"
  end

end
