module Users
  class RefreshController < ApiController
    before_action :authorize_refresh_by_access_request!

    def create
      session = JWTSessions::Session.new(payload: claimless_payload, refresh_by_access_allowed: true)
      tokens = session.refresh_by_access_payload do
        raise JWTSessions::Errors::Unauthorized, _(_("Refresh action is performed before the expiration of the access token."))
      end
      render json: { csrf: tokens[:csrf], token: tokens[:access] }
    end
  end
end
