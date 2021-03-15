# README

## Requirements

* redis : jwt refresh token ruid 저장 용도 brew 로 설치
* postgresql - app 보단 brew로 설치 추천
* imagemagick - brew

## Generator

새로운 Controller 만들 때

`rails g api items`

새로은 Serializer 만들 때

`rails g serializer item`

## PankoSerializer

`app/serializers/...` 에 serializer 위치 기본 예시

```ruby
class ItemSerializer < BaseSerializer
  attributes :id, :title, :price, :image_path, :description
  has_one :category, serializer: CategorySerializer
  has_many :images, each_serializer: ImageEachSerializer
  def image_path
    object.image_path 
  end
end
```

### basic rules

* serializer naming 규칙 
  * index - active record relation ( array ) 에 대한 serializer 는 #{모델이름}EachSerializer 로 짓는다
  * show - active record 하나 에 대한 serialzer 는 #{모델이름}Serializer 로 짓는다
  * 이 두가지는 인덱스에서 보여주는 정보와 상세 페이지에서 보여주는 정보가 크게 차이가 나기때문에 구분,
  * 두가지 경우 제외하고도 필요 하다면 만들 수 있음, 하지만 serializer가 크게 다른게 아니라면 filter를 사용해서 활용 가능
    * https://panko.dev/docs/attributes#filters

* `api_controller` method 만들어 놓음 활용

```ruby
def serialize object, serializer_name = "#{object.class.name}Serializer"
  serializer_name.constantize.new(context: context).serialize(object)
end

def each_serialize objects, serializer_name: "#{objects.name}EachSerializer"
    Panko::ArraySerializer.new(
      objects, 
      context: context,
      each_serializer: serializer_name.constantize
    ).to_a
end
```



PankoSerializer의 상세한 사용법은 링크 참고

[github]: https://github.com/panko-serializer/panko_serializer

[docs]: https://panko.dev/docs/



