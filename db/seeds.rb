# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create(email: "c.a.ellinger+admin@gmail.com", first_name: "Christie", last_name: "Ellinger", user_name: "cellingeradmin", password: "testtest", admin: true)
User.create(email: "c.a.ellinger+user@gmail.com", first_name: "Christie", last_name: "Ellinger", user_name: "cellingeruser", password: "testtest", admin: false)
User.create(email: "monizri+admin@gmail.com", first_name: "Matt", last_name: "Moniz", user_name: "mmonizadmin", password: "password", admin: true)
User.create(email: "monizri+user@gmail.com", first_name: "Matt", last_name: "Moniz", user_name: "mmonizuser", password: "password", admin: false)
User.create(email: "wesley.adams.davis+admin@gmail.com", first_name: "Wes", last_name: "Davis", user_name: "wdavisadmin", password: "password", admin: true)
User.create(email: "wesley.adams.davis+user@gmail.com", first_name: "Wes", last_name: "Davis", user_name: "wdavisuser", password: "password", admin: false)
User.create(email: "Sruthiraj.lagisetty+admin@gmail.com", first_name: "Shruthi", last_name: "Lagisetty", user_name: "slagisettyadmin", password: "password", admin: true)
User.create(email: "Sruthiraj.lagisetty+user@gmail.com", first_name: "Shruthi", last_name: "Lagisetty", user_name: "slagisettyuser", password: "password", admin: false)


Podcast.create(name: "Reply All", url: "https://gimletmedia.com/shows/reply-all")
Podcast.create(name: "Hardcore History", url: "https://www.dancarlin.com/hardcore-history-series/")
Podcast.create(name: "Welcome to Night Vale", url: "https://www.welcometonightvale.com/")
Podcast.create(name: "Darknet Diaries", url: "https://darknetdiaries.com/")
Podcast.create(name: "Nerdificent", url: "https://www.iheart.com/podcast/105-nerdificent-29083368/")
Podcast.create(name: "Conan O\'Brien Needs a Friend", url: "https://omny.fm/shows/conan-o-brien-needs-a-friend")
Podcast.create(name: "The Adventure Zone", url: "https://maximumfun.org/podcasts/adventure-zone/")
Podcast.create(name: "The Bike Shed", url: "https://www.bikeshed.fm/")
Podcast.create(name: "Office Ladies", url: "https://officeladies.com/")


Review.create(rating: 5, review: "", user: User.first, podcast: Podcast.first)
Review.create(rating: 3, review: "PJs laugh is ridiculous", user: User.second, podcast: Podcast.first)
Review.create(rating: 4, review: "Good stuff", user: User.second, podcast: Podcast.second)
Review.create(rating: 1, review: "This dude sounds like a ginger", user: User.second, podcast: (Podcast.find_by name: "Conan O\'Brien Needs a Friend"))
Review.create(rating: 4, review: "Creepy but good", user: User.first, podcast: Podcast.third)
