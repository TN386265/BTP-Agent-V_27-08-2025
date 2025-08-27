extend view entity /ZUORA001/I_DESTA with
association [1..1] to /ZUORA001/I_CUSTA on $projection.CustomerId = /ZUORA001/I_CUSTA.CustomerId and /ZUORA001/I_CUSTA.Status = '1'
{
  /ZUORA001/I_CUSTA
}
