FactoryGirl.define do

	# Notice how we're creating the associations...
	factory :user do
	    email    				"example@railstutorial.org"
	    password 				"foobar"
	    password_confirmation 	"foobar"
	    person
	end

	factory :person do
	  	profile
	end  

	factory :profile do
	  	first_name     "Marko"
	  	last_name      "Polo"
	end
end