;;;; This is an immutable version.

(defclass matrix ()
  ((m :initarg :matrix
      :reader :matrix-m)
   (inverse :reader :matrix-inverse)))

(defmethod matrix-inverse :before ((matrix matrix))
  (when (not (slot-boundp matrix 'inverse))
    (setf (slot-value matrix 'inverse)
          (calculate-inverse (matrix-m matrix)))))
