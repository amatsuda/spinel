# OpenSSL::HMAC as an instance: keyed once with `new(key, digest)`, fed
# with #update / #<<, read with #digest / #hexdigest, and copied with `dup`
# per message, as Active Support's MessageVerifier and Action Controller's
# CSRF token do. A copy's update never reaches the original.
require "openssl"
h = OpenSSL::HMAC.new("key", "SHA256")
a = h.dup.update("one").hexdigest
b = h.dup.update("two").hexdigest
p a, b, a == OpenSSL::HMAC.hexdigest("SHA256", "key", "one")
h << "da" << "ta"
p h.hexdigest, h.digest.bytesize, h.to_s == h.hexdigest
p OpenSSL::HMAC.new("k", OpenSSL::Digest.new("sha1")).update("m").hexdigest
p h.reset.update("x").hexdigest == OpenSSL::HMAC.hexdigest("SHA256", "key", "x")
