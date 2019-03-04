require 'pixeladmin_tabs/engine'
require_relative '../app/helpers/pixeladmin_tabs/tab_helper'

module PixeladminTabs
end

ActionView::Base.send :include, PixeladminTabs::TabHelper