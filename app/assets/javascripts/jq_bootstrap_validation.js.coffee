# ***
#
# App is using jqBootstrapValidation plugin
# for client-side form validations.
# See full documentation on 
# http://reactiveraven.github.io/jqBootstrapValidation/ 
#
# ***


#= require jqBootstrapValidation

$ ->
  $("input, select, textarea").not("[type=submit]").jqBootstrapValidation()