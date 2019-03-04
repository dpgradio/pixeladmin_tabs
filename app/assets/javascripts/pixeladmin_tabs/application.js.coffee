$(document).on 'click', '[data-tabbar]:not(.disabled) [data-show-tab]', (e) ->
  e.preventDefault()
  $this = $(this)
  tabName = $this.data('show-tab')

  # fix state in sticky/non sticky tab bar
  $.each $("[data-show-tab=#{tabName}]"), (index, tabButton) ->
    $tabButton = $(tabButton)
    $tabButton.closest('ul').find('li.tab').removeClass('active')
    $tabButton.closest('li.tab').addClass('active')

  tab = $this.data('show-tab')
  $tab = $("[data-tab=#{tab}]")
  $tab.parent().find('[data-tab]').hide()
  $tab.show()
  # fix state of other sticky things like redactor wysiwyg
  $(document).trigger('scroll')

  $this.trigger('changed:tab', tabName)

indicateErrorsInTabButton = ->
  $.each $("[data-show-tab]"), (index, tabButton) ->
    $tabButton = $(tabButton)
    tab = $tabButton.data('show-tab')
    $tab = $("[data-tab=#{tab}]")

    if $tab.find('.jquery-validate-error').length > 0
      $tabButton.append( $('<span>').css('color', 'red').append('*') )

$ ->
  return unless $('[data-show-tab]')[0]
  indicateErrorsInTabButton()