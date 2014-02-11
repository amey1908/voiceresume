#xml.instruct!
#xml.Response do
#    xml.Gather(:action => @post_to, :numDigits => 1) do
#        xml.Say "Press 1 to know Amay's professional qualification. Press 2 to know Amay's educational qualification. Press 3 to know why Amay is a good fit for Twilio. Press 4 to hang up and call Amay for an interview."
#    end
#end
xml.instruct!
xml.Response do
  xml.Gather(:action => @post_to, :numDigits => 1) do
    xml.Say "Hello. This is a call from Know dot me. Please select an option from the menu to know specific detail about Amay Kulkarni."
    xml.Say "Please press 1 to repeat this menu. Press 2 to know Amay's professional qualification. Press 3 to know Amay's educational qualification. Press 4 to know why Amay is a good fit for Twilio. Press 5 to hang up and call Amay for an interview."
  end
end
