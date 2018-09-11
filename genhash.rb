#! C:\Ruby193 ruby

def generate_hash
  require 'io/console'
  $go_date = Time.now.strftime("%Y%m%d")
  puts "\n--------------------------\nWelcome to Corned Beef Hash"
  puts "\n--------------------------\n"
  
  puts "Enter your username: "
  $username = gets.chomp
  
  puts "Do you want to generate hashes? (yes or no, lower case only)"
  @question = gets.chomp
  
  if @question == "yes" or @question == "Yes"
  
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

puts "\n--------------------------\nDo you want to quit? (yes or no, lower case only)"
  @question = gets.chomp
  
  if @question == "yes" or @question == "Yes"
    exit
  else
    generate_hash()
  end

end
class CornedBeefHash
  def self.md5(word) # Generate an MD5 hash
    require 'digest'
    @hash = Digest::MD5.hexdigest word
	CornedBeefHash.save("#{$username}_md5_hash.#{$go_date}.yml",@hash)
  end
  
  def self.bc(word) # Use 'BCrypt'
    require 'bcrypt'
    @hash = BCrypt::Password.create word
	CornedBeefHash.save("#{$username}_bc_hash.#{$go_date}.yml",@hash)
  end 
  
  def self.es(word,code) # Use 'Encrypted Strings'
    require 'encrypted_strings'
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