require 'yaml'
require 'ansible/vault/util'

module Ansible
  class Vault
    # The module that decrypting vault key-value pair(s)
    module KeyValueDecryptor
      # Decrypts the key-value pair(s)
      #
      # @param text [String] The encrypted text
      # @param password [String] The password for the text
      # @return [Map<String>String] The key(s) and plaintext contents of the ciphertext.
      def decrypt(text:, password:)
        # TODO: `safe_load` usage is better, but how much classes to whitelist?
        result = YAML.load(text)
        # NOTE: Handle this great Ruby YAML API
        if result == false
          result = {}
        end

        if result.respond_to?(:each)
          result.each do |k, v|
            next unless v.is_a?(String)

            result[k] = Ansible::Vault::TextDecryptor.decrypt(text: v, password: password)
          end
        else
          result = Ansible::Vault::TextDecryptor.decrypt(text: result, password: password)
        end
        result
      end

      module_function :decrypt
    end
  end
end
