Omniauth.controllers  do
    get :index do
        haml <<-HAML.gsub(/^\s*/, '')
            Login with
            =link_to('Twitter',  '/auth/twitter')
            HAML
    end

    get :profile do
        content_type :text
        current_account.to_yaml
    end

    get :destroy do
        set_current_account(nil)
        redirect url(:index)
    end

    get :auth, :map => '/auth/:provider/callback' do
        auth    = request.env["omniauth.auth"]
        account = Account.where(:provider => auth["provider"], :uid => auth["uid"]).first || Account.create_with_omniauth(auth)
        set_current_account(account)
        redirect "http://" + request.env["HTTP_HOST"] + url(:profile)
    end

end
