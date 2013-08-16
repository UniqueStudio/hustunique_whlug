require 'pp'
require 'digest'

member_pwd_value = 'hustunique'

pp Digest::MD5.hexdigest(Digest::MD5.hexdigest(member_pwd_value))
