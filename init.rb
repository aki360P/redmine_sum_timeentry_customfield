require 'redmine'
require_dependency 'rstc_hooks'

Redmine::Plugin.register :redmine_sum_timeentry_customfield do
  name 'Redmine sum timeentry customfield plugin'
  author 'Akinori Iwasaki'
  description 'Show toal value of TimeEntry customfield on issue detail view'
  version '0.1.0'
  url 'https://github.com/aki360P/redmine_sum_timeentry_customfield'
  
  project_module :redmine_sum_timeentry_customfield do
    permission :rstc_view, :rstc_view => [:index]
  end
  
  
  # setting
  settings  partial: 'rstc_global_settings/show',
            default: {
              'rstc_tracker' => '',
              'rstc_cf' => ''
               }
end