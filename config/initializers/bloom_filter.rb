
require Rails.root.join('lib', 'file_backed_bloom_filter')
BLOOM_FILTER = FileBackedBloomFilter.new(1000, 3, Rails.root.join('bloom_filter.json'))

Rails.application.config.to_prepare do
  User.pluck(:email_address).each { |email| BLOOM_FILTER.insert(email) }
end
