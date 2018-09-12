#! C:\Ruby193 ruby

# -----------------------------------------------------------------------------
# Script: genhash.rb
# Author: Robert Waight
# Date: 12/30/2014
# Keywords: 
# comments: Testing the generation of hashes with Ruby
#
# -----------------------------------------------------------------------------

def generate_hash
  begin
    require 'io/console'
  rescue LoadError
    abort("Unable to load module 'io/console'")
  end
  $go_date = Time.now.strftime("%Y%m%d")
  puts "\n--------------------------\nWelcome to Corned Beef Hash"
  puts "\n--------------------------\n"
  
  puts "Enter your username: "
  $username = gets.chomp
  
  puts "Do you want to generate hashes? (yes or no)"
  @question = gets.chomp.downcase
  
  if ['yes', 'y'].include?(@question)
  
    puts "Enter your password: "
    @password = STDIN.noecho(&:gets) 
    @password = @password.chomp
	
    #CornedBeefHash.md5 @password
    #CornedBeefHash.bc @password
    puts "Enter a separate code for the hash"
    @code = STDIN.noecho(&:gets)
    @code = @code.chomp
  
    CornedBeefHash.es(@password,@code)
    @Dir = Dir.pwd
    puts "\n--------------------------\nYour hashes have been saved to #{@Dir}"
    puts "\n--------------------------\n"
    CornedBeefEnder()
	
  else
    puts "Nothing is going to happen, have a nice day."
    CornedBeefEnder()
  end
  
end
	
def CornedBeefEnder
  puts "\n--------------------------\nDo you want to quit? (yes or no)"
  @question = gets.chomp.downcase
  
  if ['yes', 'y'].include?(@question)
    exit
  else
    generate_hash()
  end
end

class CornedBeefHash
  def self.md5(word) # Generate an MD5 hash
    begin
      require 'digest'
    rescue LoadError
      abort("Unable to load module 'digest'")
    end
    @hash = Digest::MD5.hexdigest word
    CornedBeefHash.save("#{$username}_md5_hash.#{$go_date}.yml",@hash)
  end
  
  def self.bc(word) # Use 'BCrypt'
    begin
      require 'bcrypt'
    rescue LoadError
      abort("Unable to load module 'bcrypt'")
    end
    @hash = BCrypt::Password.create word
	CornedBeefHash.save("#{$username}_bc_hash.#{$go_date}.yml",@hash)
  end 
  
  def self.es(word,code) # Use 'Encrypted Strings'
    begin
      require 'encrypted_strings'
    rescue LoadError
      abort("Unable to load module 'encrypted_strings'")
    end
    @hash = word.encrypt(:symmetric, :algorithm => 'des-ecb', :password => code)
    CornedBeefHash.save("#{$username}_es_hash.#{$go_date}.yml",@hash + "\nThe code you entered was: #{code}")
  end
  
  def self.save(myFile,myData)
    output = File.open(myFile, "w" )
    output << myData
    output.close
  end
end

generate_hash()
