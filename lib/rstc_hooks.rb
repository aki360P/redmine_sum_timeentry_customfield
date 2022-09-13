class RstcHooks < Redmine::Hook::ViewListener
    def view_issues_show_details_bottom(context={ })
      project = context[:project]
      issue = context[:issue]
      return unless enabled?(project)

      rstc_cf = Setting.plugin_redmine_sum_timeentry_customfield['rstc_cf']
      return if rstc_cf.nil?

      rstc_tracker = Setting.plugin_redmine_sum_timeentry_customfield['rstc_tracker']
      return if rstc_tracker.nil?
      return unless issue.tracker_id == rstc_tracker.to_i
      
      time_entries = TimeEntry.where(issue_id: issue.id)
      if time_entries.nil?
        total = 0.0
      elsif
        cv = CustomValue.where(customized_type: 'TimeEntry').where(customized_id: time_entries.ids)
        total = cv.where(custom_field_id: rstc_cf.to_i).sum(:value)
      end

      
      locals_params = {total: total}
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