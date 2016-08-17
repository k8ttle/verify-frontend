#!/usr/bin/env ruby

require 'sinatra'

class StubApi < Sinatra::Base
  post '/api/session' do
    status 201
    '{
      "sessionId":"blah",
      "secureCookie":"blah",
      "sessionStartTime":32503680000000,
      "transactionSimpleId":"test-rp"
    }'
  end

  get '/api/session/federation' do
    '{
      "idps":[{
        "simpleId":"stub-idp-one",
        "entityId":"http://example.com/stub-idp-one"
      }]
    }'
  end

  put '/api/session/select-idp' do
    '{
      "encryptedEntityId":"not-blank"
    }'
  end

  get '/api/session/idp-authn-request' do
    '{
      "location":"http://localhost:50300/test-saml",
      "samlRequest":"blah",
      "relayState":"whatever",
      "registration":false
    }'
  end

  put '/api/session/idp-authn-response' do
    '{
      "idpResult":"blah",
      "isRegistration":false
    }'
  end

  get '/api/transactions' do
    '{
      "public":[{
        "simpleId":"test-rp",
        "entityId":"http://example.com/test-rp",
        "homepage":"http://example.com/test-rp"
      }],
      "private":[]
    }'
  end
end

