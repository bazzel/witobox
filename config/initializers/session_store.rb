# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_witobox_session',
  :secret      => '3720c8256bf78a7294c2516963a11ff2f43a3689d113da3bc9e72bf62dc41fa74575c8116728a45656b8fdd9a1a0b9e28877d05ce9971b8ea78737639a28733c'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
