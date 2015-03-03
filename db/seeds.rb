puts  'creating orgs...'
3.times { (@organizations ||= []) << Organization.create(name: Faker::Company.name) }

puts 'creating users...'
@organizations.each do |org|
  10.times do
    first = Faker::Name.first_name
    last = Faker::Name.last_name
    User.create!(firstname: first,
                 lastname: last,
                 email: "#{first}.#{last}@example.com".downcase,
                 password: 'password',
                 organization: org)
  end
end

new_users = User.where(organization: @organizations)
puts 'creating kudos...'
new_users.each do |user|
  #TODO: clean this up
  org = user.organization
  other_users = org.users - [user]
  start_of_this_week = Time.now.at_beginning_of_week
  start_of_last_week = start_of_this_week - 1.week

  #create kudos for last week
  other_users.sample(rand(1..3)).each do |recipient|
    user.sent_kudos.create!(recipient: recipient,
                            message: Faker::Lorem.sentence,
                            created_at: rand(start_of_last_week..start_of_this_week))

  end

  #create kudos for this week
  other_users.sample(rand(1..3)).each do |recipient|
    user.sent_kudos.create!(recipient: recipient,
                            message: Faker::Lorem.sentence,
                            created_at: rand(start_of_this_week..Time.now))

  end
end

test_users = new_users.all.map do |user|
  {id:    user.id,
   email: user.email,
   org:   user.organization.name,
   name:  "#{user.firstname} #{user.lastname}",
   kudos_sent: user.sent_kudos.count,
   kudos_received: user.received_kudos.count}
end

puts "Users created for testing (password for all is 'password'):"
Formatador.display_table(test_users, [:id, :email, :name, :org, :kudos_sent, :kudos_received])
