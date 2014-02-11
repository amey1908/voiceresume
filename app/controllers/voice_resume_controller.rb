require "twilio-ruby"

class VoiceResumeController < ApplicationController
  protect_from_forgery :only => [:delete]

  # your Twilio authentication credentials
  ACCOUNT_SID = 'AC1b4ce11716f7e0e87775e92833704492'
  ACCOUNT_TOKEN = 'd91c622c0ed9cbb3443c8775f6bb8611'

  # base URL of this application
  BASE_URL = "http://http://stark-fjord-6081.herokuapp.com//voice_resume"
  #BASE_URL = "localhost:3000/voice_resume"

  # Outgoing Caller ID you have previously validated with Twilio
  CALLER_ID = '+15122702124'

  def index
  end

  # Use the Twilio REST API to initiate an outgoing call
  def makecall
    if !params['number']
      redirect_to :action => '.', 'msg' => 'Invalid phone number'
      return
    end

    # parameters sent to Twilio REST API
    data = {
        :from => CALLER_ID,
        :to => params['number'],
        :url => BASE_URL + '/reminder',
    }

    begin
      client = Twilio::REST::Client.new(ACCOUNT_SID, ACCOUNT_TOKEN)
      client.account.calls.create data
    rescue StandardError => bang
      redirect_to :action => '.', 'msg' => "Error #{bang}"
      return
    end

    redirect_to :action => '', 'msg' => "Calling #{params['number']}..."
  end
  # @end snippet

  # @start snippet
  # TwiML response that reads the reminder to the caller and presents a
  # short menu: 1. repeat the msg, 2. directions, 3. goodbye
  def reminder
    @post_to = BASE_URL + '/directions'
    render :action => "reminder.xml.builder", :layout => false
  end
  # @end snippet

  # @start snippet
  # TwiML response that inspects the caller's menu choice:
  # - says good bye and hangs up if the caller pressed 3
  # - repeats the menu if caller pressed any other digit besides 2 or 3
  # - says the directions if they pressed 2 and redirect back to menu
  def directions
    if params['Digits'] == '5'
      redirect_to :action => 'goodbye'
      return
    end

    if params['Digits'] == '4'
      redirect_to :action => 'fit'
      return
    end

    if params['Digits'] == '3'
      redirect_to :action => 'education'
      return
    end

    if !params['Digits'] or params['Digits'] != '2'
      redirect_to :action => 'reminder'
      return
    end

    @redirect_to = BASE_URL + '/reminder'
    render :action => "profession.xml.builder", :layout => false
  end
  # @end snippet

  # TwiML response saying with the goodbye message. Twilio will detect no
  # further commands after the Say and hangup
  def goodbye
    @redirect_to = BASE_URL + '/reminder'
    render :action => "goodbye.xml.builder", :layout => false
  end

  def fit
    @redirect_to = BASE_URL + '/reminder'
    render :action => "fit.xml.builder", :layout => false
  end

  def education
    @redirect_to = BASE_URL + '/reminder'
    render :action => "education.xml.builder", :layout => false
  end
end
