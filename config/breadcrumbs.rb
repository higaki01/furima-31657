crumb :root do
  link " トップページ", root_path
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).

crumb :item_new do
  link "商品登録", new_item_path
  parent :root
end

crumb :item_show do
  link "商品詳細", item_path
  parent :root
end

crumb :item_edit do
  link "商品編集", edit_item_path
  parent :item_show
end

crumb :purchase do
  link "商品購入", item_purchases_path
  parent :item_show
end

crumb :user do
  link "マイページ", user_path
  parent :root
end

crumb :login do
  link "ログイン", new_user_session_path
  parent :root
end

crumb :registration_new do
  link "ユーザー登録", new_user_registration_path
  parent :root
end

crumb :registration_edit do
  link "ユーザー情報編集", edit_user_registration_path
  parent :user
end

crumb :address_new do
  link "配送先登録", addresses_path
  parent :registration_new
end

crumb :address_new_user do
  link "配送先登録", addresses_path
  parent :user
end

crumb :address_edit do
  link "配送先変更", addresses_path
  parent :user
end

crumb :card_new do
  link "カード登録", cards_path
  parent :address_new
end

crumb :card_new_user do
  link "カード登録", cards_path
  parent :user
end

crumb :card_edit do
  link "カード変更", cards_path
  parent :user
end