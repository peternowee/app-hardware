(in-package :mu-cl-resources)

;;;;
;; NOTE
;; docker-compose stop; docker-compose rm; docker-compose up
;; after altering this file.


;;;;
;; Describe the prefixes which you'll use in the domain file here.
;; This is a short-form which allows you to write, for example,
;; (s-url "http://purl.org/dc/terms/title")
;; as (s-prefix "dct:title")

(add-prefix "dct" "http://purl.org/dc/terms/")
(add-prefix "dbpedia" "http://dbpedia.org/ontology/")
(add-prefix "foaf" "http://xmlns.com/foaf/0.1/")
(add-prefix "nfo" "http://www.semanticdesktop.org/ontologies/2007/03/22/nfo#")
(add-prefix "nie" "http://www.semanticdesktop.org/ontologies/2007/01/19/nie#")
(add-prefix "schema" "http://schema.org/")
(add-prefix "xsd" "http://www.w3.org/2001/XMLSchema#")

;;;;;
;; You can use the ext: prefix when you're still searching for
;; the right predicates during development.  This should *not* be
;; used to publish any data under.  It's merely a prefix of which
;; the mu.semte.ch organisation indicates that it will not be used
;; by them and that it shouldn't be used for permanent URIs.

(add-prefix "ext" "http://mu.semte.ch/vocabularies/ext/")
