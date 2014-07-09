$ ->
  return if typeof Stripe == "undefined"
  Stripe.setPublishableKey($("meta[name='stripe-key']").attr("content"))

  $("#cc-form").submit ->
    $("#stripe-errors").val("")
    $("input[type=submit]").attr("disabled", true)
    card = 
      number: $("#card_number").val()
      cvc: $("#cvc").val()
      expMonth: $("#card-month").val()
      expYear: $("#card-year").val()
    Stripe.createToken(card, handleStripeResponse)
    false

handleStripeResponse = (status, response) ->
  if status == 200
    
  else
    $("#stripe-errors").html(response.error.message)
    $("input[type=submit]").attr("disabled", false)