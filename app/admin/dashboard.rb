# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    link_to "Add Multiple Pictures", add_multiple_pictures_path

    columns do
      column do
        panel "Recent Users Choices" do
          ul do
            User.all.map do |user|
              user_identifier = user.name || user.email
              li link_to(user_identifier, "/pictures/results/#{user.id}")
            end
          end
        end
        panel "Developer TODOs" do
          ul do

              li 'try to upload photos on background job'
              li 'rollbar'

          end
        end
      end

      column do
        panel "Actions" do
          a(href: '/pictures/add_multiple') { h3 "Add Pictures" }
          a(href: '/pictures') { h3 "Gallery" }
        end
      end
    end
  end # content
end
