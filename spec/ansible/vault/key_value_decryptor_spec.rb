require 'spec_helper'
require 'ansible/vault/key_value_decryptor'

module Ansible
  class Vault
    RSpec.describe KeyValueDecryptor do
      describe '.decrypt(text:, password:)' do
        context 'with present `text`' do
          context 'and containing only a single key' do
            context 'and plaintext value' do
              let(:text) { File.read(fixture_path('key.yml')) }
              let(:expected) do
                {
                  "key" => 'f'
                }
              end
              it 'must return the contents of text encrypted using ansible-vault' do
                content = described_class.decrypt(text: text, password: 'ansible')
                expect(content).to eq(expected)
              end
            end

            context 'and encrypted value' do
              let(:text) { File.read(fixture_path('key.yml')) }
              let(:expected) do
                {
                  "key" => 'f'
                }
              end
              it 'must return the contents of text encrypted using ansible-vault' do
                content = described_class.decrypt(text: text, password: 'ansible')
                expect(content).to eq(expected)
              end
            end
          end
        end
      end
    end
  end
end
