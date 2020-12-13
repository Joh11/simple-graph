;;;; package.lisp

(defpackage #:simple-graph
  (:use #:cl #:alexandria)
  (:nicknames #:sg)
  (:export
   #:make-graph-from-predicate
   #:leaves
   #:roots
   #:get-out-nodes
   #:get-in-nodes
   #:remove-node
   #:get-nodes))
