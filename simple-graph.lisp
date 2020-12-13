;;;; simple-graph.lisp

(in-package #:simple-graph)

(defclass graph ()
  ((g
    :initarg :g)
   (revg
    :initarg :revg)))
