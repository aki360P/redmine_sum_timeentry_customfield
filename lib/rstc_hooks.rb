module Rstc
  class Hooks < Redmine::Hook::ViewListener
    def view_issues_show_details_bottom(context={ })
      project = context[:project]
      return unless enabled?(project)
      
      locals_params = {total: 123}
      context[:controller].send(
        :render_to_string, :partial => 'issues/addSumTimeEntryCustomfield', locals: locals_params
      )
    end
    
    private
    
    def enabled?(project)
      return false if project.nil?

      project.module_enabled? :redmine_sum_timeentry_customfield
    end
  end
end