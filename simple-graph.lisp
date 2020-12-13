;;;; simple-graph.lisp

(in-package #:simple-graph)

(defclass graph ()
  ((g
    :initarg :g
    :accessor graph.g)
   (revg
    :initarg :revg
    :accessor graph.revg)))

(defun copy-empty-hash (hash &optional value)
  "Returns a hash table with the same keys, but all the given VALUE. "
  (let ((ret (make-hash-table)))
    (loop for k being the hash-keys of hash do
      (setf (gethash k ret) value))
    ret))

(defun reverse-graph-hash (hash)
  (let ((ret (copy-empty-hash hash)))
    ;; Fill it first with nil (otherwise initial nodes of graph will
    ;; be ignored)
    (maphash (lambda (k v)
	       (declare (ignore v))
	       (setf (gethash k ret) nil))
	     hash)
    (loop for x being the hash-keys of hash do
      (loop for y in (gethash x hash) do
	(push x (gethash y ret))))
    ret))

;; ----------------------------------------------------------------------------
;; Public interface
;; ----------------------------------------------------------------------------

(defun make-graph-from-predicate (elements pred)
  "Build a graph from the given elements, assuming there is an edge
  A->B if (pred A B). "
  (let ((hash (make-hash-table)))
    (loop for x in elements do
      (setf (gethash x hash)
	    (remove-if-not (lambda (y) (funcall pred x y)) elements)))
    (make-instance 'graph
		   :g hash
		   :revg (reverse-graph-hash hash))))

(defun leaves (graph)
  "Returns the leaves of the GRAPH (nodes without any edges coming
  out). "
  (loop for k being the hash-keys of (graph.g graph)
	unless (gethash k (graph.g graph))
	  collect k))

(defun roots (graph)
  "Returns the roots of the GRAPH (nodes without any edges coming
  in). "
  (loop for k being the hash-keys of (graph.revg graph)
	unless (gethash k (graph.revg graph))
	  collect k))

(defun get-out-nodes (graph node)
  (gethash node (graph.g graph)))

(defun get-in-nodes (graph node)
  (gethash node (graph.revg graph)))

(defun remove-node (graph node)
  "Remove the given node and every edges to and from it. "
  (let ((in-nodes (get-in-nodes graph node))
	(out-nodes (get-out-nodes graph node)))
    ;; Remove the node
    (remhash node (graph.g graph))
    (remhash node (graph.revg graph))
    ;; Remove the edges
    (loop for n in in-nodes do
      (setf (gethash n (graph.g graph)) (delete node (gethash n (graph.g graph)))))
    (loop for n in out-nodes do
      (setf (gethash n (graph.revg graph)) (delete node (gethash n (graph.revg graph)))))
    graph))
