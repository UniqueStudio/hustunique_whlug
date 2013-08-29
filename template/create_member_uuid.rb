require 'pp'
require 'securerandom'
require 'digest'

pp Digest::SHA1.hexdigest(SecureRandom.uuid)
