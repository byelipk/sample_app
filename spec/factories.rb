FactoryGirl.define do
  factory :user do
    first_name  			"Pat"
    last_name				"White"
    email    				"thejuliewhite@gmail.com"
    password 				"foobar"
    password_confirmation 	"foobar"
    active                  false
    verified_email          false
  end
end