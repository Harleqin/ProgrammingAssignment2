;;;; This is a Common Lisp implementation of a matrix wrapper that provides a
;;;; cached, lazy inverse.

;;; Like the R version, it assumes that an inversion implementation is provided
;;; elsewhere.

(defclass matrix ()
  ((m :initarg :matrix
      :accessor :matrix-m)
   (inverse :reader :matrix-inverse)))

(defmethod matrix-inverse :before ((matrix matrix))
  (when (or (not (slot-boundp matrix 'inverse))
            (null (slot-value matrix 'inverse)))
    (setf (slot-value matrix 'inverse)
          (calculate-inverse (matrix-m matrix)))))

(defmethod (setf matrix-m) :after ((matrix matrix) (m array))
  (setf (slot-value matrix 'inverse) nil))
