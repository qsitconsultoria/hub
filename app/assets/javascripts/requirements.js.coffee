# ******************************************************************
#
#   #requirements
#
# ******************************************************************

# -------------------------------------
# jquery (from gem)
# -------------------------------------
#= require jquery
#= require jquery_ujs

# -------------------------------------
# uploadbox (from gem)
# -------------------------------------
#= require uploadbox

# -------------------------------------
# picturefill (from bower)
# -------------------------------------
#= require picturefill/dist/picturefill

# -------------------------------------
# fastclick (from bower)
# -------------------------------------
#= require fastclick/lib/fastclick

# -------------------------------------
# jquery autozise (from bower)
# -------------------------------------
#= require jquery-autosize/jquery.autosize


# -------------------------------------
# classlist.js (from vendor)
# -------------------------------------
#= require classList

# -------------------------------------
# slugit-jquery (from bower)
# -------------------------------------
#= require slugit-jquery/jquery.slugit

# -------------------------------------
# Slidebars (from bower)
# -------------------------------------
#= require slidebars/distribution/0.10.2/slidebars

# -------------------------------------
# Tooltips (from vendor/components)
# -------------------------------------
#= require tooltips/tooltips
tips = new Tooltips(document.body,
  tooltip:
    auto: 1
    effectClass: "slide"
  key: "tooltip" # Tooltips data attribute key.
  showOn: "mouseenter" # Show tooltip event.
  hideOn: "mouseleave" # Hide tooltip event.
  observe: 0 # Enable mutation observer (used only when supported).
)

# -------------------------------------
# typeahead.js (from vendor)
# -------------------------------------
#= require typeahead
