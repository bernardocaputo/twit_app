json.extract! twit, :id, :user_id, :content, :created_at, :updated_at

json.user do
  json.extract! twit.user, :id, :username, :email
end
