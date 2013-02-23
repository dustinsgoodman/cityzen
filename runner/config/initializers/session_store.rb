# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_runner_session',
  :secret      => '216a441b5de7ae3c33f282e4da4b48dfd6f2c06db4ddf1bc41a057e1a13c7acf4d6e7cc41961a993e90ba9b2e90050294d6911f9a5038e50f11b09e8adfde2b5'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
