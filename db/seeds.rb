PASSWORD = "supersecret"

Like.delete_all
Review.delete_all
Idea.delete_all
User.delete_all


super_user = User.create(
  name: "Jon",
  email: "js@winterfell.gov",
  password: PASSWORD
)

30.times do
    name = Faker::Name.first_name
    User.create(
      name: name,
      email: "#{name.downcase}@example.com",
      password: PASSWORD
    )
  end
  
  users = User.all

  100.times do
  i = Idea.create(
    title: Faker::Lorem.sentence,
    description: Faker::Lorem.sentences,
    user: users.sample,
    created_at: Faker::Date.backward(365 * 5)
  )
  
  if i.valid?
    i.reviews = rand(0..15).times.map do
      Review.new(
        body: Faker::Lorem.question,
        user: users.sample
      )
    end

      i.likers = users.shuffle.slice(0, rand(users.count))
  end
  
end

ideas = Idea.all
reviews = Review.all
likes = Like.all

puts Cowsay.say("Generated #{ users.count } users", :cow)
puts Cowsay.say("Generated #{ ideas.count } ideas", :cow)
puts Cowsay.say("Generated #{ reviews.count } reviews", :cow)
puts Cowsay.say("Generated #{ likes.count } likes", :cow)
