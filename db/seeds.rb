# frozen_string_literal: true

# rubocop:disable Metrics/LineLength
if Rails.env.development?
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

  User.create!(email: 'admin@dailyvibes.ca', password: 'password', password_confirmation: 'password', admin: true)
end

LISTS = %w[Inbox Today Week Archived Unsorted Groceries].freeze
TAGS = %w[bug new fixed unsorted important groceries].freeze

TASKS = [
  'Checkout different lists',
  'Create your own task item',
  'Add a tag to a task',
  'Add a note to a task',
  'buy milk 🥛',
  'buy bacon 🥓',
  'buy toast 🍞',
  'buy avacadoes 🥑',
  'buy coffee ☕️',
  'buy oatmeal 🥣',
  'buy tea 🍵'
].freeze

NOTE = %{
  # Add notes

  ## Use Markdown

  - MAKE
  - LISTS

  Even add links like so: [my search engine](https://duckduckgo.com)
}

regular_user = User.create!(email: 'user@dailyvibes.ca', password: 'password', password_confirmation: 'password')

LISTS.each do |list|
  tmp_list = List.create!(title: list, dv_default: true, public: true, user: regular_user)
  TASKS.each do |task|
    tmp_task = tmp_list.todotask_items.create(title: task)
    TAGS.each do |tag|
      tmp_task.tags.create(label: tag)
    end
    tmp_task.notes.create(content: NOTE)
  end
end
# rubocop:enable Metrics/LineLength
