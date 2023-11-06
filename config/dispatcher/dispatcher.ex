defmodule Dispatcher do
  use Matcher
  define_accept_types [
    html: [ "text/html", "application/xhtml+html" ],
    json: [ "application/json", "application/vnd.api+json" ]
  ]

  @any %{}
  @json %{ accept: %{ json: true } }
  @html %{ accept: %{ html: true } }

  define_layers [ :static, :services, :fall_back, :not_found ]

  # In order to forward the 'themes' resource to the
  # resource service, use the following forward rule:
  #
  # match "/themes/*path", @json do
  #   Proxy.forward conn, path, "http://resource/themes/"
  # end
  #
  # Run `docker-compose restart dispatcher` after updating
  # this file.

  # Resource service

  match "/individual-products/*path" do
    Proxy.forward conn, path, "http://resource/individual-products/"
  end

  match "/people/*path" do
    Proxy.forward conn, path, "http://resource/people/"
  end

  match "/transactions/*path" do
    Proxy.forward conn, path, "http://resource/transactions/"
  end

  # virus-scanner-service

  match "/virus-scanner/*path" do
    Proxy.forward conn, path, "http://virus-scanner/"
  end

  # Other services

  match "/count/*path" do
    Proxy.forward conn, path, "http://count/count/"
  end

  get "/files/:id/download", %{ layer: :services } do
    Proxy.forward conn, [], "http://file/files/" <> id <> "/download"
  end
  get "/files/*path", %{ accept: [ :json ], layer: :services } do
    Proxy.forward conn, path, "http://resource/files/"
  end
  patch "/files/*path" do
    Proxy.forward conn, path, "http://resource/files/"
  end
  post "/files/*path", %{ layer: :services } do
    Proxy.forward conn, path, "http://file/files/"
  end
  delete "/files/*path", %{ accept: [ :json ], layer: :services } do
    Proxy.forward conn, path, "http://file/files/"
  end

  match "/*_", %{ layer: :not_found } do
    send_resp( conn, 404, "Route not found.  See config/dispatcher.ex" )
  end
end
