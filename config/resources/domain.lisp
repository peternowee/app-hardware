(in-package :mu-cl-resources)

(define-resource individual-product ()
  :class (s-prefix "schema:IndividualProduct")
  :properties `((:serial-number :string ,(s-prefix "schema:serialNumber"))
                (:name :string ,(s-prefix "schema:name")))
  :has-one `((person :via ,(s-prefix "schema:owns")
                     :inverse t
                     :as "person"))
  :resource-base (s-url "http://mu.semte.ch/examples/hardware/individual-products/")
  :on-path "individual-products")

(define-resource person ()
  :class (s-prefix "schema:Person")
  :properties `((:name :string ,(s-prefix "schema:name")))
  :has-many `((individual-product :via ,(s-prefix "schema:owns")
                    :as "individual-products"))
  :resource-base (s-url "http://mu.semte.ch/examples/hardware/persons/")
  :on-path "persons")

;; reading in the domain.json
(read-domain-file "domain.json")
