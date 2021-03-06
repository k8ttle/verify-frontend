class RedirectToServiceController < ApplicationController
  before_action :hide_available_languages

  def signing_in
    redirect_to_service(
      'hub.redirect_to_service.signing_in.title',
      'hub.redirect_to_service.signing_in.transition_heading')
  end

  def start_again
    redirect_to_service(
      'hub.redirect_to_service.start_again.title',
      'hub.redirect_to_service.start_again.transition_heading')
  end

  def error
    redirect_to_service(
      'hub.redirect_to_service.start_again.title',
      'hub.redirect_to_service.start_again.transition_heading',
      is_error: true)
  end

private

  def redirect_to_service(title_key, transition_heading_key, is_error: false)
    @title = title_key
    @response_for_rp = if is_error
                         SESSION_PROXY.error_response_for_rp(
                           session['verify_session_id'],
                           cookies[CookieNames::SECURE_COOKIE_NAME]
                         )
                       else
                         SESSION_PROXY.response_for_rp(
                           session['verify_session_id'],
                           cookies[CookieNames::SECURE_COOKIE_NAME]
                         )
                       end
    @rp_name = current_transaction.rp_name
    @transition_message = t(transition_heading_key, rp_name: @rp_name)
    reset_session_cookies
    render 'redirect_to_service'
  end

  def reset_session_cookies
    reset_session
    cookies[CookieNames::SECURE_COOKIE_NAME] = CookieNames::NO_CURRENT_SESSION_VALUE
    cookies[CookieNames::SESSION_ID_COOKIE_NAME] = CookieNames::NO_CURRENT_SESSION_VALUE
  end
end
