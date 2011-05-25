class Account
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  # field <name>, :type => <type>, :default => <value>
  field :name, :type => String
  field :email, :type => String
  field :role, :type => String
  field :uid, :type => String
  field :provider, :type => String

  def self.create_with_omniauth(auth)
      create!(provider: auth["provider"],
              uid: auth["uid"],
              name: auth["name"],
              #email: auth["user_info"]["email"] if auth["user_info"], # we get this only from FB
              role: "users"
             )
  end

  def self.find_by_id(id)
      find(id) rescue nil
  end
end
