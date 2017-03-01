FactoryGirl.define do
  factory :notification do
    user_id 1
    notifier_id 1
    notification_type "MyString"
  end
end
