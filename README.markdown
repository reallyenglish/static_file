# Static File

## Basic RE setup

Gemfile:

```ruby
gem 'static_file', :git => 'git://github.com/reallyenglish/static_file.git'
```

Add the following to an initializer:

```ruby
StaticFile.add_type_url(:cms3_resource, "http://path.to.asset.server/cms")
```

## Usage

```ruby
class Person < ActiveRecord::Base
  static_file :avatar
end
```

```ruby
person = Person.create
person.avatar = StaticFile.new(:cms3_resource, "bacon.jpg")
puts person.avatar.url # => path.to.asset.server/cms/bacon.jpg
```

## Helper

A simple helper will do some leg work for you:

```ruby
<%= image_tag static_file_url(person.avatar) %>
```

```html
<img src="http://path.to.asset.server/cms/bacon.jpg"/>
```
