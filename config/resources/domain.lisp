(in-package :mu-cl-resources)

(setf *verify-content-type-header* nil)
(setf *verify-accept-header* nil)
(setf *include-count-in-paginated-responses* t)
(setf *supply-cache-headers-p* t)
(setf sparql:*experimental-no-application-graph-for-sudo-select-queries* t)
(setf *cache-model-properties-p* t)

(define-resource person ()
  :class (s-prefix "schema:Person")
  :properties `((:name :string ,(s-prefix "schema:name")
                       :required))
  :has-many `((transaction :via ,(s-prefix "schema:agent")
                           :inverse t
                           :as "transactions"))
  :resource-base (s-url "http://mu.semte.ch/examples/hardware/people/")
  :on-path "people")

(define-resource individual-product ()
  :class (s-prefix "schema:IndividualProduct")
  :properties `((:serial-number :string ,(s-prefix "schema:serialNumber"))
                (:name :string ,(s-prefix "schema:name")))
  :has-many `((transaction :via ,(s-prefix "schema:object")
                           :inverse t
                           :as "transactions"))
  :resource-base (s-url "http://mu.semte.ch/examples/hardware/individual-products/")
  :on-path "individual-products")

(define-resource transaction ()
  :class (s-prefix "schema:ReceiveAction")
  :properties `((:datetime :datetime ,(s-prefix "schema:startTime")
                           :required))
  :has-one `((person :via ,(s-prefix "schema:agent")
                     :as "new-owner")
             (individual-product :via ,(s-prefix "schema:object")
                                 :as "received-product"))
  :resource-base (s-url "http://mu.semte.ch/examples/hardware/transactions/")
  :on-path "transactions")

;; reading in the domain.json
(read-domain-file "domain.json")
