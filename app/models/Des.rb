class Des
  require 'openssl'
  require 'base64'
  ALG = 'DES-EDE3-CBC'
  KEY = "mZ4Wjs6L"
  DES_KEY = "nZ4wJs6L"

  #加密
  def self.encode(str)
    if str.present?
      str = str.to_s
      des = OpenSSL::Cipher::Cipher.new(ALG)
      des.pkcs5_keyivgen(KEY, DES_KEY)
      des.encrypt
      cipher = des.update(str)
      cipher << des.final
      return Base64.encode64(cipher)
    else
      ''
    end
  end

  #解密
  def self.decode(str)
    if str.present?
      str = str.to_s
      begin
        str = Base64.decode64(str)
        des = OpenSSL::Cipher::Cipher.new(ALG)
        des.pkcs5_keyivgen(KEY, DES_KEY)
        des.decrypt
        str = des.update(str) + des.final
        str.try(:force_encoding, "utf-8")
      rescue => err
        ""
      end
    else
      ''
    end
  end
end
