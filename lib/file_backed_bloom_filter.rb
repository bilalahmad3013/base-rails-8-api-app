require 'json'
require 'digest'

class FileBackedBloomFilter
  def initialize(size, num_hashes, file_path)
    @size = size
    @num_hashes = num_hashes
    @file_path = file_path
    @bit_array = load_bit_array
  end


  def insert(item)
    @num_hashes.times do |i|
      index = hash_function(item, i) % @size
      @bit_array[index] = 1
    end
    save_bit_array
  end

  def possibly_contains?(item)
    @num_hashes.times do |i|
      index = hash_function(item, i) % @size
      return false if @bit_array[index] == 0
    end
    true
  end

  private

  def hash_function(item, i)
    Digest::SHA256.hexdigest("#{item}-#{i}").to_i(16)
  end

  def load_bit_array
    if File.exist?(@file_path)
      Array.new(@size, 0)
    end
  end

  def save_bit_array
    File.write(@file_path, JSON.generate(@bit_array))
  end
end
