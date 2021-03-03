class GenerateSeed
  @@users = User.ransack(email_cont: "test").result
  @@categories = Category.all
  @@items = Item.ransack(title_cont: "상품").result
  PREFIXES = ["오래된 ", "새로운 ", "흥미로운 ", "따끈따끈한 ", "센스 있는 ", "기분 좋은 ", "즐거운 ", "전문적인 "]
  ADDRESSES = ["서초구 서초동", "종로구 이화동", "용산구 이촌동", "성동구 마장동", "광진구 광장동", "중랑구 면목동", "성북구 석관동", "도봉구 창동", "노원구 상계동", "은평구 수색동", "서대문구 신촌동", "마포구 공덕동", "양천구 목동", "구로구 신도림동", "영등포구 여의동", "동작구 신대방동", "관악구 보라매동", "강남구 신사동", "송파구 방이동", "강동구 둔촌동"]
  TITLES = ["너무 좋아요", "헬로 월드", "이게 간지다", "너무 친절해요", "배송이 느려요", "또 이용할게요", "사장님이 미쳤어요", "상태가 완전 최고에요", "언제 또 입고되나요?", "사이즈 교환요", "정보좀요", "쿨거래 감사요", "항상 애용하고 있습니다", "많이 파세요", "별점 5점 드립니다", "칭찬칭찬합니다"]
  CATEGORIES = %w(패션 뷰티 유아동 식품 주방용품 생활용품 인테리어 가전 스포츠 자동차 여행 도서 완구 문구 반려동물 건강식품)
  PRICES = [10000, 15000, 19000, 20000, 30000, 40000, 50000, 49900]
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
          address1: "서울시 #{ADDRESSES.sample}",
          address2: "#{rand(10000)}호",
          image: File.open("#{Rails.root}/public/photos/user#{rand(3) + 1}.jpg"),
        }
        User.create!(object_hash)
      end
      
      @@users = User.ransack(email_cont: 'test').result
    end
  end

  # Post.instance_eval do
  #   def generate_seed destroy
  #     Post.destroy_all if destroy
  #     20.times do
  #       object_hash = {
  #         title: "#{PREFIXES.sample}영상",
  #         body: Faker::Lorem.sentence(word_count: 15),
  #         image: File.open("#{Rails.root}/public/photos/restaurant#{rand(3) + 1}.jpg"),
  #       }
  #       @@users.sample.posts.create!(object_hash)
  #       puts 'POST 생성'
  #     end
  #   end
  # end
  Item.instance_eval do
    def generate_seed 
      50.times do
        object_hash = {
          title: "#{PREFIXES.sample} 상품",
          price: PRICES.sample,
          category: Category.all.sample,
          description: Faker::Lorem.sentence(word_count: 100),
          image: File.open("#{Rails.root}/public/photos/item#{rand(3) + 1}.jpg"),
          zipcode: "111111",
          address1: "서울시 #{ADDRESSES.sample}",
          address2: "#{rand(10000)}호",
          user_id: @@users.sample.id,
          category_id: @@categories.sample.id
        }
        object = Item.create(object_hash)
        3.times { object.images.create(image: File.open("#{Rails.root}/public/photos/item#{rand(3) + 1}.jpg")) }

      end
    end
  end

  Category.instance_eval do
    def generate_seed
      CATEGORIES.each_with_index do |category_title, index|
        self.create(
          title: category_title, 
          body: Faker::Lorem.sentence(word_count: 100),
          position: index,
          image: File.open("#{Rails.root}/public/icons/icon#{index}.png")
        )
      end
    end
  end

  Notice.instance_eval do
    def generate_seed
      ["새롭게 앱이 출시되었습니다!", "경품 추첨 안내", "추석 연휴 안내", "고객 상담 시간 안내", "저희가 투자유치에 성공했습니다!"].each do |title|
        Notice.create(title: title, body: Faker::Lorem.sentence(word_count: 100))
      end
    end
  end
  #   12.times do
  #     object_hash = {
  #       email: Faker::Internet.email,
  #       password: "password",
  #       name: "#{Faker::Name.last_name}#{Faker::Name.first_name}",
  #       phone: get_phone,
  #       gender: [1, 2].sample,
  #       description: get_description,
  #       zipcode: "111111",
  #       address1: "서울시 #{ADDRESSES.sample}",
  #       address2: "#{rand(10000)}호",
  #       image: File.open("#{Rails.root}/public/photos/user#{rand(3) + 1}.jpg")
  #     }

  #     generate_tags object_hash

  #     User.provider.create(object_hash)
  #     puts "USER 생성"
  #   end
  # end

  # def generate_follows
  #   User.all.each do |user|
  #     User.all.sample(10).each do |friend|
  #       if user != friend
  #         user.follow!(friend) unless user.following?(friend)
  #       end
  #     end
  #   end
  # end

  # def generate_likes
  #   targets = generate_targets

  #   User.all.each do |user|
  #     targets.each {|target| user.like!(target) unless user.like?(target)}
  #     puts "LIKE 생성"
  #   end
  # end

  # def generate_reviews
  #   targets = generate_targets
  #   User.find_each do |user|
  #     targets.each do |target|
  #       user.reviews.create!(title: TITLES.sample, star: 3 + rand(3), target: target, body: TITLES.sample + ' ' + TITLES.sample)
  #     end
  #     puts "REVIEW 생성"
  #   end
  # end

  # def generate_comments
  #   targets = generate_targets

  #   User.all.each do |user|
  #     targets.each do |target|
  #       user.comments.create(body: TITLES.sample)
  #     end
  #     puts "REVIEW 생성"
  #   end
  # end

  # def generate_notifications
  #   targets = []
  #   targets += Comment.all.sample(5)
  #   targets += Like.all.sample(5)
  #   targets += Review.all.sample(5)

  #   targets.each do |target|
  #     target.target_notifications.create(title: "#{target.title} - 새로운 소식이 있습니다", user: get_user)
  #   end
  # end

  # def generate_notices
  #   ["새롭게 앱이 출시되었습니다!", "경품 추첨 안내", "추석 연휴 안내", "고객 상담 시간 안내", "저희가 투자유치에 성공했습니다!"].each do |title|
  #     Notice.create(title: title, body: Faker::Lorem.sentence(word_count: 100))
  #   end
  # end

  # def generate_faqs
  #   (["서비스 이용 안내", "환불 정책 안내", "가장 많이 묻는 질문 베스트", "예상 견적이 어떻게 되나요?", "유지보수는 어떻게 되나요?"] * 2).each do |title|
  #     Faq.create(title: title, body: Faker::Lorem.sentence(word_count: 100))
  #   end
  # end

  # def generate_categories
  #   CATEGORIES.each_with_index {|category_title, index| Category.create(title: category_title, body: Faker::Lorem.sentence(word_count: 100), position: index, image: File.open("#{Rails.root}/public/icons/icon#{index}.png"))}
  # end

  # def generate_pages
  #   [["이용약관", :tos, Faker::Lorem.sentence(word_count: 100)], ["개인정보보호정책", :privacy, Faker::Lorem.sentence(word_count: 100)]].each do |page_content|
  #     Page.create(title: page_content[0], name: page_content[1], body: page_content[2])
  #   end
  # end
end