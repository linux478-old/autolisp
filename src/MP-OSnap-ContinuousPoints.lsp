;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Command: FROM
;;; Description: Finds a new point by keeping track of previous point
;;; Depends On: MP:OSnap->Continuous
;;; Return: Point
;;; Notes: This command is meant to be used transparently in a command
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun C:From ()
  (MP:OSnap->ContinuousPoints)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Function: MP:OSnap->Continuous
;;; Description: Continuous get a point from the previous point
;;; Return: Point
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun MP:OSnap->ContinuousPoints ( / pt1 pt2)
  ; save the first point
  (setq pt1 (getpoint "\nPoint"))
  (while (setq pt2 (getpoint pt1 "\nNext Point: "))
    ; save the new point
    (setq pt1 pt2)
  )
  ; return the save point
  (command "_non" pt1)
)
