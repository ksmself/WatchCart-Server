class Category < ApplicationRecord
  include ImageUrl
  validates :title, presence: true
  has_many :items, dependent: :nullify
  has_many :movies, dependent: :nullify

  # Instance method 만들기
  # self가 안 붙어 있으면 instance method
  def puts_category_title
    puts self.title
  end

  # rails c에서 
  # Category.puts_category_titles 라고 입력하면 
  # Category title만 주르륵 출력된다
  # class method이고 self로 시작해야 한다.
  # find_each는 반복문
  def self.puts_category_titles
    self.find_each do |category|
      puts category.title
    end
  end
end
