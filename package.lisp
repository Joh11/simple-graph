;;;; package.lisp

(defpackage #:simple-graph
  (:use #:cl)
  (:export
   #:make-graph-from-predicate
   #:leaves
   #:roots
   #:get-out-nodes
   #:get-in-nodes
   #:remove-node))
