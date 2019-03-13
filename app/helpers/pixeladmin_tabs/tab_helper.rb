module PixeladminTabs::TabHelper
  def tabs_for partial_path:, html: nil, prerender_tabs: true, &block
    TabCollection.new(self, partial_path: partial_path, html: html, prerender_tabs: prerender_tabs).render(&block)
  end

  class TabCollection
    delegate :content_tag, :link_to, :t, to: :view_context
    attr_reader :tabs, :view_context, :partial_path, :html, :prerender_tabs

    def initialize(view_context, partial_path:, html: nil, prerender_tabs: nil)
      @view_context = view_context
      @partial_path = partial_path
      @html = html || {}
      @tabs = []
      @prerender_tabs = prerender_tabs
    end

    def add name, locals: {}, link: nil, active: nil, &block
      tab = Tab.new(name, locals: locals, active: active)
      @tabs << tab
      render_tab(tab, link: link)
    end

    def render &block
      render_tabs(&block) + render_tab_content
    end

    private

    def render_tabs(&block)
      html[:class] ||= 'tabs-wrapper'
      content_tag :div, html do
        content_tag :ul, class: 'nav nav-tabs' do
          block.call(self)
        end
      end
    end

    def render_tab_content
      tabs_to_render = tabs.select{ |tab| prerender_tabs || tab.active? }
      tabs_to_render.map do |tab|
        style = tab.active? ? '' : 'display: none;'
        content_tag :div, class: "tab-content tab-#{tab.name}", style: style, data: { tab: tab.name } do
          view_context.render "#{partial_path}#{tab.name}", tab.locals
        end
      end.join("\n").html_safe
    end

    def render_tab tab, link: nil
      locals ||= {}
      classes = []
      classes << 'active' if tab.active?
      classes << "tab"
      content_tag(:li, class: classes.join(' ')) do
        link_to t(".#{tab.name}"), link || '#', data: { 'show-tab' => tab.name }
      end
    end

    class Tab
      attr_accessor :name, :locals, :active
      alias_method :active?, :active
      def initialize name, locals:, active:
        @name = name
        @locals = locals
        @active = active
      end
    end
  end
end
