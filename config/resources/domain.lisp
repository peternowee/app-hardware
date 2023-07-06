(in-package :mu-cl-resources)

(define-resource person ()
  :class (s-prefix "schema:Person")
  :properties `((:name :string ,(s-prefix "schema:name")))
  :has-many `((transaction :via ,(s-prefix "ext:newOwner")
                           :inverse t
                           :as "transactions"))
  :resource-base (s-url "http://mu.semte.ch/examples/hardware/people/")
  :on-path "people")

(define-resource individual-product ()
  :class (s-prefix "schema:IndividualProduct")
  :properties `((:serial-number :string ,(s-prefix "schema:serialNumber"))
                (:name :string ,(s-prefix "schema:name")))
  :has-many `((transaction :via ,(s-prefix "ext:receivedProduct")
                           :inverse t
                           :as "transactions"))
  :resource-base (s-url "http://mu.semte.ch/examples/hardware/individual-products/")
  :on-path "individual-products")

(define-resource transaction ()
  :class (s-prefix "ext:Transaction")
  :properties `((:datetime :datetime ,(s-prefix "xsd:dateTime")))
  :has-one `((person :via ,(s-prefix "ext:newOwner")
                     :as "person"))
  :has-one `((individual-product :via ,(s-prefix "ext:receivedProduct")
                                 :as "individual-product"))
  :resource-base (s-url "http://mu.semte.ch/examples/hardware/transactions/")
  :on-path "transactions")

;; reading in the domain.json
(read-domain-file "domain.json")
