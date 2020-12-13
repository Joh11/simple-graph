;;;; simple-graph.asd

(asdf:defsystem #:simple-graph
  :description "Simple graph library"
  :author "Johan Felisaz"
  :license  "MIT"
  :version "0.0.1"
  :serial t
  :components ((:file "package")
               (:file "simple-graph")))
