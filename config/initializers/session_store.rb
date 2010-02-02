# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_drama-mita_session',
  :secret      => 'e4c440e2d1ed4124eac15d25b53beea683fbb3205d0bfcaa81836430d1480c3032be83919812868feb3a222758c447f262dc3b2510e663eeeb2d447f38de9f66'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
