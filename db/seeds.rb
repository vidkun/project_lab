# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = ['Sam', 'Jane','Fred','Kim','Jack']

seed_file = Rails.root.join('db', 'seeds.yml')
seed_data = YAML::load_file(seed_file)

seed_data['users'].each do |user_name, user_data|
  User.create!(user_data)
end

seed_data['projects'].map do |project_name, project_data|
  project_data['users'].map!{|user_name| User.find_by(name: user_name.capitalize) }
  project_data['creator'] = project_data['users'].first
  project_data['due_date_at'] = Time.now()+1.month
  project_data['tasks'].map! do |task|
    task['creator_id'] = User.find_by(name: task['creator'].capitalize).id
    task['user'] = User.find_by(name: task['user'].capitalize)
    task.except!('creator')
    Task.create!(task)
  end
  Project.create!(project_data)
end