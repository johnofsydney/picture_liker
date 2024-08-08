# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    # div class: "blank_slate_container", id: "dashboard_default_message" do
    #   span class: "blank_slate" do
    #     span I18n.t("active_admin.dashboard_welcome.welcome")
    #     small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #   end
    # end


    link_to "Add Multiple Pictures", add_multiple_pictures_path

    # Here is an example of a simple dashboard with columns and panels.

    columns do
      column do
        panel "Recent Users Choices" do
          ul do
            User.all.map do |user|
              li link_to(user.email, pictures_path)
            end
          end
        end
      end

      column do
        panel "Info" do
          a(href: "https://www.activeadmin.info") { h3 "ActiveAdmin" }
          a(href: '/pictures/add_multiple') { h3 "Add Pictures" }
          para "Welcome to ActiveAdmin."
        end
      end
    end
  end # content
end
