class GenerateSeed
  @@users = User.ransack(email_cont: "test").result
  def self.exec(cls)
    cls.generate_seed 
  end
  %w(users).each{|inst| 
    eval("def self.#{inst}
      @@#{inst}
    end 
    ")}


  User.instance_eval do
    def generate_seed 
      20.times.each_with_index do |v|
        object_hash = {
          email: "test#{sprintf("%02d", (v+1))}@insomenia.com",
          password: "password",
          name: "#{Faker::Name.last_name}#{Faker::Name.first_name}",
          phone: "010-#{rand(9000) + 1000}-#{rand(9000) + 1000}",
          gender: [1, 2].sample,
          description: Faker::Lorem.sentence(word_count: 100),
          zipcode: "111111",
          address2: "#{rand(10000)}호",
          image: File.open("#{Rails.root}/public/photos/user#{rand(3) + 1}.jpg"),
        }
        User.create!(object_hash)
      end
      @@users = User.ransack(email_cont: 'test').result
    end
  end

end