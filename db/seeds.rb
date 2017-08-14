# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

tutorials = YAML::load_file(Rails.root.join('db', 'seeds', 'tutorials.yml'))

tutorials.each do |tutorial|
  record = Tutorial.where(title: tutorial['title']).first_or_create

  tutorial['tutorial_steps'].each do |step|
    record.tutorial_steps.where(content: step['content']).first_or_create(step)
  end
end

faqs = YAML::load_file(Rails.root.join('db', 'seeds', 'faqs.yml'))

faqs.each do |faq|
  Faq.where(question: faq['question']).first_or_create(faq)
end

service_specific_posts = YAML::load_file(Rails.root.join('db', 'seeds', 'service_specific_posts.yml'))

service_specific_posts.each do |post|
  ServiceSpecificPost.where(title: post['title']).first_or_create(post)
end

branch_of_service_contacts = YAML::load_file(Rails.root.join('db', 'seeds', 'branch_of_service_contacts.yml'))

branch_of_service_contacts.each do |contact|
  BranchOfServiceContact.where(branch: contact['branch']).first_or_create(contact)
end

entitlements = YAML::load_file(Rails.root.join('db', 'seeds', 'entitlements.yml'))

entitlements.each do |entitlement|
  Entitlement.where(rank: entitlement['rank']).first_or_create(entitlement)
end
