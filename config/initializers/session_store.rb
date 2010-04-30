# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_simpleserver_session',
  :secret      => '9dcafda33a61f2b253d4a43e07043751fca5a8122b8e9480fcbf89e5a779b70edb876e4144482751b8eb079b01f0b69994acc27a16253693f1c3c0c2358d6a6b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
